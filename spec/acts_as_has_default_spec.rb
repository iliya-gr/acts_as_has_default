require File.expand_path('./spec_helper', File.dirname(__FILE__))

describe 'A class that has default' do 

  let(:user) { User.create }

  it 'should set default to true on creation' do 
    address = Address.create()
    address.default.should be_true
  end

  context 'when default not set' do 
    before do 
      @first  = user.addresses.build
      @second = user.addresses.build
      user.save
    end

    it 'should set first as default' do 
      @first.default.should be_true
    end

    it 'should not set second as default' do 
      @second.default.should be_false
    end

    it 'should set second as default when first get destroyed' do 
      @first.destroy
      @second.reload.default.should be_true
    end

    it 'should set first as not default when second set as default' do 
      @second.default = true 
      @second.save

      @first.reload.default.should be_false
    end

  end

end