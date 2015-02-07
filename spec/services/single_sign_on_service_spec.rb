describe SingleSignOnService do
  let(:user) { create(:user) }

  describe '.redirect_url' do
  	subject { SingleSignOnService.new }

    it 'should throw exception if request was generated without sso parameter' do
      expect { subject.redirect_url }.to raise_error
    end

    it 'should throw exception if request was generated with incorrect key' do
      subject.query_string = "?sso=&sig="
      expect { subject.redirect_url }.to raise_error
    end
  end
end