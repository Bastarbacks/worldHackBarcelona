package models;

import play.Logger;

import com.restfb.json.JsonArray;
import com.restfb.json.JsonObject;

public class Song {

    private final String title;
    private final String artist;
    private final String album;
    private final String cover;

    public Song(JsonObject musicObjectJson) throws ParseSongException {

        Logger.info("musicObjectJson -> %s", musicObjectJson);

        boolean isValid = musicObjectJson == null || "music.song".equals(musicObjectJson.getString("type"));
        if (!isValid) {
            throw new ParseSongException();
        }

        JsonObject musicData = musicObjectJson.getJsonObject("data");

        title = musicObjectJson.getString("title");
        JsonArray images = musicObjectJson.getJsonArray("image");
        if (images != null && images.length() > 0) {
            cover = images.getJsonObject(0).getString("url");
        }
        else {
            cover = "";
        }
        JsonArray artists = musicData.getJsonArray("musician");
        if (artists != null && artists.length() > 0) {
            artist = artists.getJsonObject(0).getString("name");
        }
        else {
            artist = "";
        }
        JsonArray albums = musicData.getJsonArray("album");
        if (artists != null && artists.length() > 0) {
            album = albums.getJsonObject(0).getJsonObject("url").getString("title");
        }
        else {
            album = "";
        }
    }

    @Override
    public String toString() {
        return "Song [title=" + title + ", artist=" + artist + ", album=" + album + ", cover=" + cover + "]";
    }

    public class ParseSongException extends Throwable {

    }
}
