import SwiftUI

struct GameView: View {
    private enum Constants {
        static let buttonFrameWidth: CGFloat = 95
        static let buttonFrameHeight: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 10
        static let discardPileBlockWidth: CGFloat = 50
        static let discardPileBlockHeight: CGFloat = 80
        static let discardPileBlockCornerRadius: CGFloat = 15
        static let discardPileBlockBorderLines: CGFloat = 2
        static let deckBlockWidth: CGFloat = 60
        static let deckBlockHeight: CGFloat = 90
        static let deckTextSize: CGFloat = 10
    }

    @ObservedObject var gameViewModel: GameViewModel
    let cardViewBuilder: CardViewBuilder

    var body: some View {
        VStack {
            AspectVGrid(items: gameViewModel.cardsOnScreen, aspectRatio: 2 / 3) { card in
                cardViewBuilder.build(
                    for: card,
                    isColorBlindModeEnabled: gameViewModel.isColorBlindModeEnabled
                )
                .onTapGesture {
                    gameViewModel.didSelect(card: card)
                }
            }
            .navigationTitle("\(gameViewModel.timerTitle)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button {
                    gameViewModel.dealThreeMoreCards()
                } label: {
                    threeMoreCardsButton
                }
                .disabled(gameViewModel.isMoreCardAvailable),

                trailing: Button {
                    gameViewModel.startNewGame()
                } label: {
                    newGameButton
                }
            )
            HStack {
                deckBlock
                Spacer()
                // code for the solo version of the game >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                Text("Score: \(gameViewModel.score)")
                    .bold()
                // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                Spacer()
                discardPileBlock
            }
            .padding(.horizontal, 30)

//            HStack {
//                Button {
//                    gameViewModel.didSelect(player: gameViewModel.firstPlayer)
//                } label: {
//                    firstPlayerButton
//                }
//                .disabled(gameViewModel.isSecondPlayerActive)
//
//                Spacer()
//                Text("\(gameViewModel.firstPlayer.score) - \(gameViewModel.secondPlayer.score)")
//                    .font(.largeTitle)
//                Spacer()
//
//                Button {
//                    gameViewModel.didSelect(player: gameViewModel.secondPlayer)
//                } label: {
//                    secondPlayerButton
//                }
//                .disabled(gameViewModel.isFirstPlayerActive)
//            }
//            .padding()
        }
    }
    
    private var discardPileBlock: some View {
        VStack {
            RoundedRectangle(cornerRadius: Constants.discardPileBlockCornerRadius)
                .strokeBorder(lineWidth: Constants.discardPileBlockBorderLines)
                .frame(width: Constants.discardPileBlockWidth, height: Constants.discardPileBlockHeight)
            Text("Discard pile").font(.system(size: Constants.deckTextSize))
        }
    }
    
    private var deckBlock: some View {
        VStack {
            ZStack {
                ForEach(gameViewModel.deck) { card in
                    cardViewBuilder.build(
                        for: card,
                        isColorBlindModeEnabled: gameViewModel.isColorBlindModeEnabled
                    )
                }
            }
            .frame(width: Constants.deckBlockWidth, height: Constants.deckBlockHeight)
            
            Text("Deck").font(.system(size: Constants.deckTextSize))
        }
    }

    private var threeMoreCardsButton: some View {
        Text("+3 cards")
            .frame(width: Constants.buttonFrameWidth, height: Constants.buttonFrameHeight)
            .background(gameViewModel.moreCardsButtonColor)
            .foregroundColor(.white)
            .cornerRadius(Constants.buttonCornerRadius)
    }

    private var newGameButton: some View {
        Text("New game")
            .frame(width: Constants.buttonFrameWidth, height: Constants.buttonFrameHeight)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(Constants.buttonCornerRadius)
    }

//    private var firstPlayerButton: some View {
//        Text("\(gameViewModel.firstPlayer.name)")
//            .frame(width: Constants.buttonFrameWidth, height: Constants.buttonFrameHeight)
//            .background(gameViewModel.firstPlayerButtonColor)
//            .foregroundColor(.white)
//            .cornerRadius(Constants.buttonCornerRadius)
//    }
//
//    private var secondPlayerButton: some View {
//        Text("\(gameViewModel.secondPlayer.name)")
//            .frame(width: Constants.buttonFrameWidth, height: Constants.buttonFrameHeight)
//            .background(gameViewModel.secondPlayerButtonColor)
//            .foregroundColor(.white)
//            .cornerRadius(Constants.buttonCornerRadius)
//    }
}
