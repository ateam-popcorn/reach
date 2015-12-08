class Profile < ActiveRecord::Base
  belongs_to :user
  before_save :set_age_from_birthday

  enum sex: [:male, :female]
  enum prefecture: [
    :hokkaido,
    :aomori,
    :iwate,
    :miyagi,
    :akita,
    :yamagata,
    :fukushima,
    :ibaraki,
    :tochigi,
    :gumma,
    :saitama,
    :chiba,
    :tokyo,
    :kanagawa,
    :niigata,
    :toyama,
    :ishikawa,
    :fukui,
    :yamanashi,
    :nagano,
    :gifu,
    :shizuoka,
    :aichi,
    :mie,
    :shiga,
    :kyoto,
    :osaka,
    :hyogo,
    :nara,
    :wakayama,
    :tottori,
    :shimane,
    :okayama,
    :hiroshima,
    :yamaguchi,
    :tokushima,
    :kagawa,
    :ehime,
    :kochi,
    :fukuoka,
    :saga,
    :nagasaki,
    :kumamoto,
    :oita,
    :miyazaki,
    :kagoshima,
    :okinawa
  ]
  enum job: [
    :employee,
    :manager,
    :exective,
    :government,
    :temporary,
    :self,
    :soho,
    :farming,
    :profession,
    :part_time,
    :homemaker,
    :student,
    :no_job,
    :others
  ]

  private

  def set_age_from_birthday
    self.age = (Time.zone.today - birthday.to_date).to_i / 365
  end
end
