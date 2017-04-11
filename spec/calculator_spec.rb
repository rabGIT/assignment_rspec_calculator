# Your code here
require 'calculator'

describe Calculator do
  describe '#initialize ' do
    it 'accepts no arguments' do
      expect{ Calculator.new }.not_to raise_error
    end

    it 'accepts a boolean true argument' do
      expect{ Calculator.new(true) }.not_to raise_error
    end

    it 'accepts a boolean false argument' do
      expect{ Calculator.new(false) }.not_to raise_error
    end

    it 'errors on a non-boolean argument' do
      expect{ Calculator.new('fred') }.to raise_error
    end

    it 'sets the environment variable @stringify correctly for no argument' do
      calc = Calculator.new()
      expect( calc.instance_variable_get(:@stringify) ).to be false
    end

    it 'sets the environment variable @memory correctly for no argument' do
      calc = Calculator.new()
      expect( calc.instance_variable_get(:@memory) ).to be_nil
    end

    it 'sets the environment variable @stringify correctly for true' do
      calc = Calculator.new(true)
      expect( calc.instance_variable_get(:@stringify) ).to be true
    end

    it 'sets the environment variable @memory correctly for true' do
      calc = Calculator.new(true)
      expect( calc.instance_variable_get(:@memory) ).to be_nil
    end
  end

  describe '#add ' do
    it 'returns the sum of its arguments' do
      expect(Calculator.new.add(1, 2)).to eq(3)
    end
    it 'returns the sum of its arguments with fractions' do
      expect(Calculator.new.add(1.25, 2.4)).to eq(3.65)
    end
    it 'properly handles negative numbers with positive result' do
      expect(Calculator.new.add(4, -2)).to eq(2)
    end
    it 'properly handles negative numbers with negative result' do
      expect(Calculator.new.add(4, -6)).to eq(-2)
    end
    it 'returns a number' do
      expect(Calculator.new.add(4, -6)).to be_a(Numeric)
    end
  end

  describe '#subtract ' do
    it 'returns the difference of its arguments' do
      expect(Calculator.new.subtract(5, 2)).to eq(3)
    end
    it 'returns the difference of its arguments with fractions' do
      expect(Calculator.new.subtract(3.65, 2.4)).to eq(1.25)
    end
    it 'properly handles negative numbers with positive result' do
      expect(Calculator.new.subtract(4, -2)).to eq(6)
    end
    it 'properly handles negative numbers with negative result' do
      expect(Calculator.new.subtract(4, 6)).to eq(-2)
    end
    it 'returns a number' do
      expect(Calculator.new.subtract(4, -6)).to be_a(Numeric)
    end
  end

  describe '#multiply ' do
    it 'returns the product of its arguments' do
      expect(Calculator.new.multiply(5, 2)).to eq(10)
    end
    it 'returns the product of its arguments with fractions' do
      expect(Calculator.new.multiply(3.65, 2.4)).to eq(8.76)
    end
    it 'properly handles negative numbers with positive result' do
      expect(Calculator.new.multiply(-3, -2)).to eq(6)
    end
    it 'properly handles negative numbers with negative result' do
      expect(Calculator.new.multiply(-2, 1)).to eq(-2)
    end
    it 'returns a number' do
      expect(Calculator.new.multiply(4, -6)).to be_a(Numeric)
    end
  end

  describe '#divide ' do
    it 'returns the division of its arguments' do
      expect(Calculator.new.divide(6, 2)).to eq(3)
    end
    it 'returns the division of its arguments with fractions' do
      expect(Calculator.new.divide(3.6, 1.2)).to eq(3)
    end
    it 'properly handles negative numbers with positive result' do
      expect(Calculator.new.divide(-4, -2)).to eq(2)
    end
    it 'properly handles negative numbers with negative result' do
      expect(Calculator.new.divide(-2, 1)).to eq(-2)
    end
    it 'returns an Integer when no remainder' do
      expect(Calculator.new.divide(4, 2)).to be_a(Integer)
    end
    it 'returns an Integer ' do
      expect(Calculator.new.divide(5, 2)).to be_a(Float)
    end
    it 'returns an error on divide by 0' do
      expect{ Calculator.new.divide(4, 0)}.to raise_error(ArgumentError)
    end
  end

  describe '#pow ' do
    it 'returns the power of its arguments' do
      expect(Calculator.new.pow(2, 3)).to eq(8)
    end
    it 'returns the power of its arguments with fractions' do
      expect(Calculator.new.pow(27, 1/3.0)).to eq(3)
    end
    it 'properly handles negative numbers with positive result' do
      expect(Calculator.new.pow(-2, 2)).to eq(4)
    end
    it 'properly handles negative numbers with negative result' do
      expect(Calculator.new.pow(-2, 3)).to eq(-8)
    end
    it 'returns a number' do
      expect(Calculator.new.pow(4, -6)).to be_a(Numeric)
    end
  end

  describe '#sqrt ' do
    it 'returns the sqrt of its arguments' do
      expect(Calculator.new.sqrt(4)).to eq(2)
    end
    it 'returns the sqrt of its arguments with fractions' do
      expect(Calculator.new.sqrt(9.1)).to be_within(0.1).of(3)
    end
    it 'properly handles negative argument' do
      expect{ Calculator.new.sqrt(-2) }.to raise_error(ArgumentError)
    end
    it 'returns an Integer when no remainder' do
      expect(Calculator.new.sqrt(4)).to be_a(Integer)
    end
    it 'returns an Float' do
      expect(Calculator.new.sqrt(5)).to be_a(Float)
    end
    it 'returns an Float with two decimal scale' do
      val = Calculator.new.sqrt(13)
      expect(val.to_s.length).to eq(val.floor.to_s.length + 3)
    end
  end

  describe 'memory= ' do
    let(:calc) { Calculator.new }
    it 'sets the environment variable @memory correctly' do
      calc.memory=(7)
      expect( calc.instance_variable_get(:@memory) ).to eq(7)
    end
    it 'sets the environment variable @memory correctly replacing previous value' do
      calc.memory=(7)
      calc.memory=(13)
      expect( calc.instance_variable_get(:@memory) ).to eq(13)
    end
  end

  describe 'memory ' do
    let(:calc) { Calculator.new }

    it 'returns nil at initialization' do
      expect( calc.memory ).to be_nil
    end
    it 'returns the value' do
      calc.memory=(7)
      expect( calc.memory ).to eq(7)
    end

    it 'clears memory after returning the value' do
      calc.memory=(7)
      calc.memory
      expect( calc.memory ).to be_nil
    end
  end

  describe 'stringify ' do
    let(:calc) { Calculator.new(true) }

    it '#add returns a string' do
      expect(calc.add(4, 5)).to be_a(String)
    end

    it '#subtract returns a string' do
      expect(calc.subtract(4, 5)).to be_a(String)
    end

    it '#multiple returns a string' do
      expect(calc.multiply(4, 5)).to be_a(String)
    end

    it '#divide returns a string' do
      expect(calc.divide(4, 5)).to be_a(String)
    end

    it '#pow returns a string' do
      expect(calc.pow(4, 5)).to be_a(String)
    end

    it '#sqrt returns a string' do
      expect(calc.sqrt(4)).to be_a(String)
    end
  end
end
