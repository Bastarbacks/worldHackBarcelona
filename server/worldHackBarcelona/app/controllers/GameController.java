package controllers;

import java.util.ArrayList;
import java.util.List;

import models.Song;
import models.Song.ParseSongException;

import org.apache.commons.lang.StringUtils;

import play.Logger;
import play.mvc.Controller;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.json.JsonArray;
import com.restfb.json.JsonObject;

public class GameController extends Controller {

    private static final String ACCESS_TOKEN_TEST  = "AAAFk6jZAg8FYBAIVehSSy2tDbKuieUa1sURQypZBTgPa0xOEQVwZAsxegOfJB7kTJkZAuneZAIerJX2MzWHZBlZBZA2DLKADZBVDTZCfNAyJZBUloFeHWg7bLIS";

    private static final int    NUMBER_SONGS_LIMIT = 2;

    public static void play(String access_token) {

        if (StringUtils.isEmpty(access_token)) {
            access_token = ACCESS_TOKEN_TEST;
        }

        Logger.info("access_token -> %s", access_token);

        List<Song> songs = fetchUserSongs(access_token, NUMBER_SONGS_LIMIT);

        // User user = facebookClient.fetchObject("me", User.class);
        // Logger.info("user -> %s", user);

        render();
    }

    private static List<Song> fetchUserSongs(String accessToken, int limit) {

        List<Song> songs = new ArrayList<Song>();

        FacebookClient facebookClient = new DefaultFacebookClient(accessToken);

        JsonObject musicsConnection = facebookClient.fetchObject("me/music.listens", JsonObject.class);

        JsonArray musicJsonArray = musicsConnection.getJsonArray("data");

        String musicId = "";
        Song song = null;
        for (int idx = 0; idx < musicJsonArray.length() && idx < limit; idx++) {
            JsonObject musicSimpleObjectJson = musicJsonArray.getJsonObject(idx).getJsonObject("data").getJsonObject("song");

            Logger.info("musicSimpleObjectJson -> %s", musicSimpleObjectJson);

            musicId = musicSimpleObjectJson.getString("id");

            Logger.info("music id -> %s", musicId);

            JsonObject musicCompleteInfoJson = facebookClient.fetchObject(musicId, JsonObject.class);

            try {
                song = new Song(musicCompleteInfoJson);
                songs.add(song);
                Logger.info("song -> %s", song);
            }
            catch (ParseSongException e) {
                e.printStackTrace();
            }
        }

        return songs;
    }

}
