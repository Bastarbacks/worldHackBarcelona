package models;

import com.restfb.json.JsonObject;

public class SimpleSong {

    protected final String id;
    protected final String title;

    public SimpleSong(JsonObject simpleMusicObjectJson) {

        this.id = simpleMusicObjectJson.getString("id");
        this.title = simpleMusicObjectJson.getString("title");
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    @Override
    public boolean equals(Object obj) {

        if (obj == null || !(obj instanceof Song))
            return false;

        if (id != null && ((SimpleSong) obj).id != null)
            return id.equals(((SimpleSong) obj).id);

        return id.equals(((SimpleSong) obj).id);
    }

    @Override
    public int hashCode() {
        return id.length();
    }

    @Override
    public String toString() {
        return "SimpleSong [id=" + id + ", title=" + title + "]";
    }
}
