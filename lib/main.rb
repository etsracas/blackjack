class Player

  attr_reader(:point, :hands)

  def initialize(deck)
    @hands = []
    @point = 0
    2.times do
      draw(deck)
    end
  end

  def draw(deck)
    now_card = deck.drawCard
    @hands.push(now_card)
    puts "あなたの引いたカードは #{now_card.suit} の #{now_card.number} です。"
    @point += now_card.point
  end

  def show
    @hands.each do |hand|
      hand.show
    end
  end

  def showPoint
    puts "あなたの現在の得点は#{@point}です。"
  end
end

class Dealer

  attr_reader(:point, :hands)

  def initialize(deck)
    @hands = []
    @point = 0
    draw(deck)
    drawHide(deck)
  end

  def draw(deck)
    now_card = deck.drawCard
    @hands.push(now_card)
    puts "ディーラーの引いたカードは #{now_card.suit} の #{now_card.number} です。"
    @point += now_card.point
  end

  def drawHide(deck)
    @secound_card = deck.drawCard
    @hands.push(@secound_card)
    puts "ディーラーの2枚目のカードは分かりません。"
    @point += @secound_card.point
  end

  def show
    @hands.each do |hand|
      hand.show
    end
  end

  def showPoint
    puts "ディーラーの現在の得点は#{@point}です。"
  end

  def showSecondCard
    puts "ディーラーの2枚目のカードは #{@secound_card.suit} の #{@secound_card.number} でした。"
  end
end

class Card

  attr_reader(:suit, :number)

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  def show
    puts "#{@number} : #{@suit}"
  end

  def point
    case @number
    when 'A'
      1
    when 'J', 'Q', 'K'
      10
    else
      @number.to_i
    end
  end

end

class Deck
  def initialize
    @cards = []
    build
  end

  def build
    for s in ["spade", "heart", "diamond", "club"] do
      for v in ['A', *'2'..'10', 'J', 'Q', 'K'] do
        @cards << Card.new(s, v)
      end
    end
  end

  def show
    @cards.each do |card|
      card.show
    end
  end

  def drawCard
    cards_length = @cards.length
    @cards.delete_at(rand(cards_length))
  end

end

# 初期化
exit_flag = "Y"
deck = Deck.new

# ゲーム開始メッセージ
puts "☆★☆★☆★☆★☆★ ブラックジャックへようこそ！ ☆★☆★☆★☆★☆★"
puts "ゲームを開始します。"

# プレイヤーのカードを引く（初回）
player = Player.new(deck)

# ディーラーのカードを引く（初回）
dealer = Dealer.new(deck)

# ループ開始（プレイヤーのターン）
while exit_flag == "Y" && player.point < 21
  # プレイヤーの現在の得点を表示
  player.showPoint

  # カードを引くかどうかの選択
  puts "カードを引きますか？引く場合はYを、引かない場合はNを入力してください。"
  exit_flag = gets.chop

  if exit_flag == "Y"
    player.draw(deck)
  end
end

# ループ開始（ディーラーのターン）
dealer.showSecondCard

while dealer.point < 17
  # ディーラーの現在の得点を表示
  dealer.showPoint

  # ディーラーがカードを引く
  dealer.draw(deck)
end

# ゲーム結果表示
player.showPoint
dealer.showPoint

# 勝敗結果
if player.point > 21
  puts "あなたの負けです。"
elsif dealer.point > 21 || player.point > dealer.point
  puts "あなたの勝ちです。"
elsif player.point == dealer.point
  puts "同点です。"
else
  puts "あなたの負けです。"
end

puts "ブラックジャック終了！また遊んでね★"