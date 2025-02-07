import Foundation

class TicTacToe {
    var board: [[String]]
    let playerSymbols = ["X", "O"]
    var currentPlayer: Int = 0
    var scores: [Int]

    init() {
        board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
        scores = [0, 0]
    }

    func resetBoard() {
        board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
    }

    func printBoard() {
        for row in board {
            print(row.map { " \($0) " }.joined(separator: "|"))
            print("---+---+---")
        }
    }

    func printScores() {
        print("Scores: Player 1 (X) - \(scores[0]), Player 2 (O) - \(scores[1])")
    }

    func isWin() -> Bool {
        for i in 0..<3 {
            if board[i][0] != " " && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                return true
            }
            if board[0][i] != " " && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                return true
            }
        }
        if board[0][0] != " " && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return true
        }
        if board[0][2] != " " && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return true
        }
        return false
    }

    func isDraw() -> Bool {
        return board.joined().allSatisfy { $0 != " " }
    }

    func play() {
        while true {
            resetBoard()
            while true {
                printBoard()
                printScores()
                print("Player \(currentPlayer + 1) (\(playerSymbols[currentPlayer])): Enter row and column (0-2): ", terminator: "")
                if let input = readLine(),
                   let row = Int(input.split(separator: " ").first ?? ""),
                   let col = Int(input.split(separator: " ").last ?? ""),
                   row >= 0, row < 3, col >= 0, col < 3, board[row][col] == " " {
                    board[row][col] = playerSymbols[currentPlayer]
                    if isWin() {
                        printBoard()
                        print("Player \(currentPlayer + 1) wins!")
                        scores[currentPlayer] += 1
                        break
                    }
                    if isDraw() {
                        printBoard()
                        print("It's a draw!")
                        break
                    }
                    currentPlayer = 1 - currentPlayer
                } else {
                    print("Invalid move. Try again.")
                }
            }
            print("Do you want to play again? (yes/no): ", terminator: "")
            if let input = readLine(), input.lowercased() != "yes" {
                print("Final Scores: Player 1 (X) - \(scores[0]), Player 2 (O) - \(scores[1])")
                break
            }
        }
    }
}

let game = TicTacToe()
game.play()
