package controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import models.ParseSongException;
import models.Question;
import models.SimpleSong;
import models.Song;

import org.apache.commons.lang.StringUtils;

import play.Logger;
import play.mvc.Controller;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.json.JsonArray;
import com.restfb.json.JsonObject;

public class GameController extends Controller {

    // private static final String ACCESS_TOKEN_TEST =
    // "AAAFk6jZAg8FYBAIVehSSy2tDbKuieUa1sURQypZBTgPa0xOEQVwZAsxegOfJB7kTJkZAuneZAIerJX2MzWHZBlZBZA2DLKADZBVDTZCfNAyJZBUloFeHWg7bLIS";
    private static final String ACCESS_TOKEN_TEST  = "AAAFk6jZAg8FYBAGm16ZBZAn5NpiJOzp1x1wpfB7aw7YcNlPocDJLeNO4Rv814xbtiKZAvTgKyORADwZAFKLz43xvS45P798kpb2yxNplwxVMaGcLK2pMT";

    private static final int    NUMBER_SONGS_LIMIT = 10;

    public static void play(String access_token) {

        if (StringUtils.isEmpty(access_token)) {
            access_token = ACCESS_TOKEN_TEST;
        }

        Logger.info("access_token -> %s", access_token);

        FacebookClient facebookClient = new DefaultFacebookClient(access_token);

        List<SimpleSong> allSimpleSongs = fetchUserSongs(facebookClient);

        if (allSimpleSongs == null || allSimpleSongs.size() == 0) {

            Logger.info("user without songs!");

            renderTestGame();
        }
        else {

            Collections.shuffle(allSimpleSongs);
            List<Song> songs = fetchSongsInfo(facebookClient, allSimpleSongs, NUMBER_SONGS_LIMIT);

            List<Question> questions = generateQuestions(allSimpleSongs, songs);

            Logger.info("questions -> %s", questions);

            // User user = facebookClient.fetchObject("me", User.class);
            // Logger.info("user -> %s", user);

            render(questions);
        }
    }

    private static List<Question> generateQuestions(List<SimpleSong> allSimpleSongs, List<Song> songs) {

        List<Question> questions = new ArrayList<Question>();

        for (Song song : songs) {

            Question question = Question.newQuestion(song, allSimpleSongs);

            questions.add(question);
        }

        return questions;
    }

    private static List<SimpleSong> fetchUserSongs(FacebookClient facebookClient) {

        List<SimpleSong> allSongs = new ArrayList<SimpleSong>();

        JsonObject musicsConnection = facebookClient.fetchObject("me/music.listens", JsonObject.class);

        JsonArray musicJsonArray = musicsConnection.getJsonArray("data");

        SimpleSong song = null;
        for (int idx = 0; idx < musicJsonArray.length(); idx++) {
            JsonObject musicSimpleObjectJson = musicJsonArray.getJsonObject(idx).getJsonObject("data").getJsonObject("song");

            song = new SimpleSong(musicSimpleObjectJson);

            allSongs.add(song);
        }

        return allSongs;
    }

    private static List<Song> fetchSongsInfo(FacebookClient facebookClient, List<SimpleSong> simpleSongs, int limit) {

        List<Song> songs = new ArrayList<Song>();

        String musicId = "";
        Song song = null;
        for (int idx = 0; idx < simpleSongs.size() && idx < limit; idx++) {

            SimpleSong simpleSong = simpleSongs.get(idx);

            musicId = simpleSong.getId();

            if (StringUtils.isEmpty(musicId)) {
                continue;
            }

            // Logger.info("music id -> %s", musicId);

            JsonObject musicCompleteInfoJson = facebookClient.fetchObject(musicId, JsonObject.class);

            try {
                song = new Song(musicCompleteInfoJson);
                songs.add(song);
                // Logger.info("song -> %s", song);
            }
            catch (ParseSongException e) {
                e.printStackTrace();
            }
        }

        return songs;
    }

    private static void renderTestGame() {

        int numberOfGameTests = 4;

        Random rnd = new Random();

        int gameTest = rnd.nextInt(numberOfGameTests);

        render(String.format("testGames/test_game_%d.json", gameTest));
    }
}
