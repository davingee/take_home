require 'rails_helper'

RSpec.describe EarthQuake, type: :model do

  describe 'class methods' do

    let(:query_params) { 
      { 
        latitude:     34.0522,
        longitude:    -118.2437,
        multiplier:   6334,
        start_time:   3.days.ago, 
        end_time:     0.days.ago
      }
    }

    context 'within_date_range' do
      it 'should retrieve records within date range' do
        expect(
          EarthQuake.within_date_range(
            { start_time: 3.days.ago, end_time: 0.days.ago }
          ).count
        ).to eq(2)
      end
    end

    context 'query_view' do
      it 'should get earthquakes that could be felt by given lat and lng with in time range' do
        expect(
          EarthQuake.query_view(query_params).to_a.count
        ).to eq(1)

        expect(
          EarthQuake.query_view(query_params).first.earth_quake_id
        ).to eq('ci37925536')
      end

      it 'should get earthquakes that could be felt by given lat and lng with in time range' do
        expect(
          EarthQuake.query_view(query_params.merge(start_time:  2.years.ago)).to_a.count
        ).to eq(2)

        expect(
          EarthQuake.query_view(query_params.merge(start_time:  2.years.ago)).last.earth_quake_id
        ).to eq('ci37923808')
      end
    end

    context 'default_start_time' do
      it 'should eq 30 days at begining of day' do
        expect(
          EarthQuake.default_start_time
        ).to eq(30.days.ago.to_date.beginning_of_day)
      end
    end

    context 'default_end_time' do
      it 'should eq end of day today' do
        expect(
          EarthQuake.default_end_time
        ).to eq(Date.today.end_of_day)
      end
    end

  end

  describe 'instance methods' do
    context 'city' do
      it 'parse city out of text' do
        e = EarthQuake.new(place: '12km NNE of Banning, CA')
        expect(e.city).to eq('Banning')
      end
    end

    context 'state' do
      it 'parse city out of text' do
        e = EarthQuake.new(place: '12km NNE of Banning, CA')
        expect(e.state).to eq('CA')
      end
    end
  end

end
