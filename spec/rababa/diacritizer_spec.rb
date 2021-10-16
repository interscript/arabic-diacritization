# frozen_string_literal: true

require 'open-uri'
require 'tmpdir'

RSpec.describe Rababa::Diacritizer do

  ONNX_FILE = 'https://github.com/secryst/rababa-models/releases/download/0.1/diacritization_model.onnx'
  ONNX_PATH = File.join(Dir.mktmpdir, "model.onnx")
  DEFAULT_CONFIG = {
    'session_name' => 'base',
    'text_encoder' => 'ArabicEncoderWithStartSymbol',
    'text_cleaner' => 'valid_arabic_cleaners',
    'max_len' => 200,
    'batch_size' => 32
  }

  before(:all) do
    URI.open(ONNX_FILE) do |remote|
      File.open(ONNX_PATH, "wb") do |file|
        file.write(remote.read)
      end
    end
  end

  let(:diacritizer) do
    Rababa::Diacritizer.new(ONNX_PATH, DEFAULT_CONFIG)
  end

  PASSING_TESTS = {
    'إبراهيم' =>
    'إِبْرَاهِيم',

    'عاشت فلسطين حرة' =>
    'عَاشَتْ فِلَسْطِينُ حُرَّة',

    'صوت رؤية يُرضيني' =>
    'صَوْتَ رُؤْيَةٍ يُرْضِينِي',

    '26 سبتمبر العقبة' =>
    '26 سَبْتَمْبَرِ العَقَبَة',

    'قطر' =>
    'قَطَر',

    'وقال ادخلوا مصر إن شاء الله آمنين' =>
    'وَقَالَ ادْخُلُوا مِصْرَ إِن شَاءَ اللَّهُ آمِنِينَ',

    'يذهب المسلمون كل عام إلى المملكة العربية السعودية لأداء مناسك الحج' =>
    'يَذْهِبُ الْمُسْلِمُونَ كُلَّ عَامٍ إِلَى الْمَمْلَكَةِ الْعَرَبِيَّةِ السُّعُودِيَّةِ لِأَدَاءِ مَنَاسِكِ الْحَجِّ',

    'لقد كان في يوسف وإخوته آيات للسائلين' =>
    'لَقَدْ كَانَ فِي يُوسُفَ وَإِخْوَتِهِ آيَاتٌ لِلسَّائِلِينَ',

    'الحمد لله رب العالمين' =>
    'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',

    'وما كان الله ليعذبهم وأنت فيهم' =>
    'وَمَا كَانَ اللَّهُ لِيُعَذِّبَهُمْ وَأَنْتَ فِيهِمْ',

    'نحن نقص عليك أحسن القصص' =>
    'نَحْنُ نَقُصُّ عَلَيْكَ أَحْسَنَ الْقَصَصِ',

    'سأذهب إلى برج eiffel' =>
    'سَأُذْهِبُ إِلَى بُرْجِ eiffel',

    '# گيله پسمير الجديد 34' =>
    '# گيَلِهُ پسُمِيْرٌ الجَدِيدُ 34'
  }

  FAILING_TESTS = {
  }

  PASSING_TESTS.each_pair do |source, target|
    it "ensures source text (#{source}) has no diacritics" do
      expect(diacritizer.remove_diacritics(source)).to eq source
    end
  end

  PASSING_TESTS.each_pair do |source, target|
    it "diacriticizes #{source}" do
      expect(diacritizer.diacritize_text(source)).to eq target
    end
  end

  FAILING_TESTS.each_pair do |source, target|
    it "diacriticizes #{source}" do
      pending
      expect(diacritizer.diacritize_text(source)).to eq target
    end
  end

end
