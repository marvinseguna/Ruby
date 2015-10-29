require 'rspec'
require 'highline'

describe '#string' do
	let(:highline) { Highline.new }

	it 'contains undesirable characters' do
		expect{ highline.handle_string 'chuck norr%s', :exclude => ['%', '^']}.to raise_error(ArgumentError, 'String contains undesirable characters!')
	end
	
	it 'does not contain undesirable characters' do
		expect( highline.handle_string "", :exclude => ['%', '^']).to be true #or be_truthy
	end
	
	it 'must have specific characters' do
		expect( highline.handle_string 'LolKekbur11', :include => [ :uppercase, :lowercase, :number] ).to be true
	end
	
	it 'does not have the required characters' do
		expect{ highline.handle_string 'LolKekbur', :include => [ :upper, :lower, :number]}.to raise_error(ArgumentError, 'String character requirements not met!')
	end
end