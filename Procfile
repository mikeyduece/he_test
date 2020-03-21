web: bundle exec puma -t 5:5 -p ${PORT:-5000} -e ${RACK_ENV:-development}
log: tail -f log/development.log
release: rails db:migrate