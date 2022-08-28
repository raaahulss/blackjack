class CardShoe
    NUMERIC_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    FACE_CARDS = ['J', 'Q', 'K']
    ACE_CARD = 'A'
    SUIT = NUMERIC_CARDS + FACE_CARDS + [ACE_CARD]

    # Default number of decks in the card show is 1
    def initialize(number_of_decks = 1)
        @number_of_decks = number_of_decks
        @cards = []
        setup_cards
    end

    # Setup CardShoe based on the number of decks requested
    def setup_cards
        for _ in 1..@number_of_decks
            add_deck
        end
    end

    # Add a deck to the CardShoe
    def add_deck
        4.times { @cards.concat(SUIT) }
    end

    # Draw a single card from the CardShoe
    def draw_card
        card = @cards.sample
        @cards.delete_at(@cards.index(card))
        card
    end

    # Number of cards left in the CardShoe
    def card_count
        @cards.count
    end

    # Reshuffle the cards in the CardShoe
    def reshuffle
        @cards = []
        setup_cards
    end

    # Print the details of the current state of CardShoe
    def print_deck
        puts("\nCards remaining in the CardShoe\n")
        puts(@cards.join(','))
        puts("\nNumber of cards remaining in the CardShoe\n")
        puts(@cards.count)
    end
end