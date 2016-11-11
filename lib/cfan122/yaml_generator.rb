# frozen_string_literal: true
require 'yaml'

module Cfan122

  class YamlGenerator
    attr_reader :path, :text

    def initialize params = {}
      @file_name, @key, @text = params[:name], params[:key], params[:text]
      @path = "./lib/#{self.class.name.split("::")[0]}/meta/#{@file_name}.yml"
    end

    def open
      YAML.load_file(path) if File.exist?(path)
    end

    def save
      data = open || {}
      data[@key] = @text
      File.open(path, "w"){|file| file.write(data.to_yaml) }
    end

    def self.generate_exam_info province = :ln, type = 'C1', subject = 3
      self.generate_exam_subject province, type, subject
      self.generate_exam_agency province, type, subject
      self.generate_exam_location province, type, subject
    end

    def self.generate_exam_subject province = :ln, type = 'C1', subject = 3
      YamlGenerator.new(name: province, key: "exam_subject_#{type}_#{subject}", text: ExamSubject.execute({province: province, type: type, subject: subject})).save
    end

    def self.generate_exam_agency province = :ln, type = 'C1', subject = 3
      YamlGenerator.new(name: province, key: "exam_agency_#{type}_#{subject}", text: ExamAgency.execute({province: province, type: type, subject: subject})).save
    end

    def self.generate_exam_location province = :ln, type = 'C1', subject = 3
      YamlGenerator.new(name: province, key: "exam_location_#{type}_#{subject}", text: ExamLocation.execute({province: province, type: type, subject: subject})).save
    end

  end
end

