default:
	rake sunspot:solr:start
reindex:
	rake sunspot:solr:reindex
stop:
	rake sunspot:solr:stop
dump: 
	pg_dump -a EquipmentSystem_development > db.sql
reload:
	psql -d EquipmentSystem_development -f db.sql
