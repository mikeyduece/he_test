web: bundle exec puma -t 5:5 -p ${PORT:-5000} -e ${RACK_ENV:-development}
log: tail -f log/development.log
worker: bundle exec sidekiq -q cache -c 10
release: rails db:migrate