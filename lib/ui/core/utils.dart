String getEmojiByScore(int score) {
  if (score == 100) {
    return '🤓';
  }
  if (score > 60) {
    return '🙂';
  }
  return '😟';
}
