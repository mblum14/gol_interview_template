require 'rspec'
require 'rspec/its'
require './gol'

describe 'The Game of Life' do
  def x
    Cell.new(false)
  end

  def o
    Cell.new(:alive)
  end
  describe 'can be initialized by rows' do
    let(:game) { Gol.new([x, x, x],
                         [o, o, o],
                         [x, x, x]) }
    subject { game }
    its(:height) { is_expected.to eq(3) }
    its(:width)  { is_expected.to eq(3) }

    it 'initializes a new board' do
      expected = [
        [x, x, x],
        [o, o, o],
        [x, x, x]
      ]
      expect(game.board).to eq(expected)
    end

    it 'calculates the next state' do
      game.next!
      expected = [
        [x, o, x],
        [x, o, x],
        [x, o, x]
      ]
      expect(game.board).to eq(expected)
    end

  end

  describe Cell do
    describe 'next!' do
      it 'stays dead with less than three neighbors' do
        cell = Cell.new(false)
        cell.neighbors = 2
        cell.next!
        expect(cell).not_to be_alive
      end

      it 'is born with exactly three neighbors' do
        cell = Cell.new(false)
        cell.neighbors = 3
        cell.next!
        expect(cell).to be_alive
      end

      it 'dies with 0 neighbors' do
        cell = Cell.new('o')
        cell.neighbors = 0
        cell.next!
        expect(cell).not_to be_alive
      end

      it 'dies with 1 neighbor' do
        cell = Cell.new('o')
        cell.neighbors = 1
        cell.next!
        expect(cell).not_to be_alive
      end

      it 'continues living with exactly 2 neighbors' do
        cell = Cell.new('o')
        cell.neighbors = 2
        cell.next!
        expect(cell).to be_alive
      end

      it 'continues living with exactly 3 neighbors' do
        cell = Cell.new('o')
        cell.neighbors = 3
        cell.next!
        expect(cell).to be_alive
      end

      it 'dies with more than 3 neighbors' do
        cell = Cell.new('o')
        cell.neighbors = 4
        cell.next!
        expect(cell).not_to be_alive
      end
    end
  end
end
