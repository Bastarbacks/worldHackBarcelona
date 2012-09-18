package models;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import play.Logger;

public class Question {

    private static final int MAX_TRIES_LOOK_FOR_ANSWER = 50;
    private static final int NUMBER_ANSWERS            = 4;

    private enum QuestionType {
        ARTIST_FOR_SONG, ARTIST_FOR_ALBUM
    }

    private final String      title;
    private int               correctAnswer;
    private ArrayList<Answer> answers;
    private Song              correctSong;

    public static Question newQuestion(Song song, List<SimpleSong> allSimpleSongs) {

        long seed = new Date().getTime();
        Random rnd = new Random(seed);
        Question question = null;

        int randomQuestion = rnd.nextInt(QuestionType.values().length);

        if (randomQuestion == 0) {
            question = newQuestionSongForArtist(song, allSimpleSongs);
        }
        else if (randomQuestion == 1) {
            question = newQuestionSongForArtist(song, allSimpleSongs);
            // question = newQuestionArtistForSong(song, allSimpleSongs);
        }

        question.correctSong = song;
        question.answers = new ArrayList<Answer>(NUMBER_ANSWERS);
        question.correctAnswer = rnd.nextInt(NUMBER_ANSWERS);

        Answer answer = null;
        for (int answerIdx = 0; answerIdx < NUMBER_ANSWERS; answerIdx++) {

            if (answerIdx == question.correctAnswer) {
                answer = new Answer(song);
            }
            else {
                try {
                    answer = getAnswerFromOtherSongsExlcudingTheAnswer(rnd, allSimpleSongs, song);

                }
                catch (Exception e) {
                    e.printStackTrace();
                    continue;
                }
            }

            question.answers.add(answer);
        }

        return question;
    }

    private static Answer getAnswerFromOtherSongsExlcudingTheAnswer(Random rnd, List<SimpleSong> allSimpleSongs, Song song) throws Exception {

        SimpleSong simpleSong = null;
        int tryIdx = 0;
        do {

            if (tryIdx >= MAX_TRIES_LOOK_FOR_ANSWER) {
                Logger.error("getAnswerFromOtherSongsExlcudingTheAnswer");
                throw new Exception();
            }

            int randomSongPosition = rnd.nextInt(allSimpleSongs.size());

            Logger.info("random --------> %d", randomSongPosition);

            simpleSong = allSimpleSongs.get(randomSongPosition);

            tryIdx++;
        }
        while (simpleSong.equals(song));

        return new Answer(simpleSong);
    }

    private static Question newQuestionSongForArtist(Song song, List<SimpleSong> allSimpleSongs) {

        String title = String.format("Qué canción es del artista '%s'", song.getArtist());

        Question question = new Question(title);

        return question;
    }

    // private static Question newQuestionArtistForSong(Song song, List<SimpleSong> allSimpleSongs) {
    // // TODO Auto-generated method stub
    // return null;
    // }

    private Question(String title) {

        this.title = title;
        this.correctAnswer = 0;
        this.answers = new ArrayList<Answer>();
    }

    @Override
    public String toString() {
        return "Question [title=" + title + ", correctAnswer=" + correctAnswer + ", answers=" + answers + ", correctSong=" + correctSong + "]";
    }
}
