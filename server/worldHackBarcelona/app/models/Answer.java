package models;

public class Answer {

    private final SimpleSong simpleSong;

    public Answer(SimpleSong simpleSong) {

        this.simpleSong = simpleSong;
    }
    
    public String getTitle()
    {
        return simpleSong.title;
    }

    @Override
    public String toString() {
        return "Answer [simpleSong=" + simpleSong + "]";
    }
}
