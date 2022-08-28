require './card_shoe.rb'

#################################################################
######################### INSTRUCTIONS ##########################
#################################################################
# 1. Preferred ruby version 2.7
# 2. Clone the repo and cd to home directory
# 2. Start the ruby console using `irb`
# 3. Require the file `require './blackjack.rb'`
# 4. Play a single hand of Blackjack `Blackjack.play_one_hand`
# 5. Play a full game of Blackjack `Blackjack.play_full_game`
# 6. Happy Gambling :)
#################################################################

class Blackjack
    class << self
        # To play a single hand of Blackjack
        def play_one_hand
            new.play_one_hand
        end

        # To play until the card shoe needs to be reshuffled
        def play_full_game
            new.play_full_game
        end
    end

    # Initialize the game of Blackjack
    def initialize
        @card_shoe = CardShoe.new(6)
        reset_hands
    end

    def reset_hands
        @player_hand = []
        @dealer_hand = []
    end

    # Play a single hand of Blackjack
    def play_one_hand
        # Player draws/is delt two cards
        2.times { draw_player_card }
        # Dealer draws/is delt two cards
        2.times { draw_dealer_card }

        # Player keeps drawing cards until the score is 17+
        while player_score < 17
            draw_player_card
        end

        # If the player busted, Dealer wins!
        if player_score > 21
            print_result('Dealer')
            return
        end

        # Dealer keeps drawing cards until the score is better than player score
        while dealer_score < player_score
            draw_dealer_card
        end

        # If the dealer busted, Player wins!
        if dealer_score > 21
            print_result('Player')
            return
        end

        compute_result
    end

    # Play a full game of Blackjack
    def play_full_game
        # Keep play as long as we have more than 2 decks of cards
        while @card_shoe.card_count > 104
            reset_hands
            play_one_hand
        end
    end

    private

    # Calculate player's score
    def player_score
        score(@player_hand)
    end

    # Calculate dealer's score
    def dealer_score
        score(@dealer_hand)
    end

    # Give a hand, evaluate the score of the hand
    def score(hand)
        total = 0
        ace_count = 0

        # Get the raw total of the hand
        hand.each do |card|
            if CardShoe::NUMERIC_CARDS.include?(card)
                total += card
            elsif CardShoe::FACE_CARDS.include?(card)
                total += 10
            else
                total += 11
                ace_count += 1
            end
        end

        # If the total is > 21 and we have aces in the hand,
        # we can convert ace score from 11 -> 1
        while ace_count > 0
            if total > 21
                total -= 10
                ace_count -= 1
            else
                break
            end
        end

        total
    end

    # Draw a card from the CardShoe and add it to the player's hand
    def draw_player_card
        @player_hand.append(@card_shoe.draw_card)
    end

    # Draw a card from the CardShoe and add it to the dealer's hand
    def draw_dealer_card
        @dealer_hand.append(@card_shoe.draw_card)
    end

    # Compute the result of the hand, based on the scores
    def compute_result
        if player_score == dealer_score
            print_result('Push! No one')
        elsif player_score > dealer_score
            print_result('Player')
        else
            print_result('Dealer')
        end
    end

    # Print the result of a hand
    def print_result(winner)
        puts("\n\nStart of a hand")
        puts("Dealer Cards are - #{@dealer_hand} and the score is #{dealer_score}")
        puts("Player Cards are - #{@player_hand} and the score is #{player_score}")
        puts("Number of cards left in CardShoe =  #{@card_shoe.card_count}")
        puts("#{winner} wins!")
        puts("End of a hand\n\n")
    end
end