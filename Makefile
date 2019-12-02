CC = g++ -std=c++11
CFLAGS  = -Wall -O3 -std=c++11
LDFLAGS = -lpthread

all: CONSENT-correction CONSENT-polishing explode merge

explode: explode.o
	$(CC) -o bin/explode src/explode.o

explode.o: src/explode.cpp
	$(CC) -o src/explode.o -c src/explode.cpp $(CFLAGS)

merge: merge.o
	$(CC) -o bin/merge src/merge.o

merge.o: src/merge.cpp
	$(CC) -o src/merge.o -c src/merge.cpp $(CFLAGS)	

CONSENT-correction: alignmentPiles.o reverseComplement.o kMersProcessing.o CONSENT-correction.o DBG.o main.o
	$(CC) -o bin/CONSENT-correction src/main.o src/kMersProcessing.o src/reverseComplement.o src/alignmentPiles.o src/CONSENT-correction.o src/DBG.o BMEAN/bmean.o BMEAN/utils.o BMEAN/BOA/align_lpo2.o  BMEAN/BOA/align_lpo_po2.o  BMEAN/BOA/align_score.o  BMEAN/BOA/black_flag.o  BMEAN/BOA/buildup_lpo.o  BMEAN/BOA/create_seq.o  BMEAN/BOA/fasta_format.o  BMEAN/BOA/heaviest_bundle.o  BMEAN/BOA/lpo_format.o  BMEAN/BOA/lpo.o   BMEAN/BOA/msa_format.o  BMEAN/BOA/numeric_data.o  BMEAN/BOA/remove_bundle.o  BMEAN/BOA/seq_util.o  BMEAN/BOA/stringptr.o BMEAN/Complete-Striped-Smith-Waterman-Library/src/*.o $(LDFLAGS)

CONSENT-correction.o: src/CONSENT-correction.cpp src/CONSENT.h src/CONSENT-correction.h src/alignmentPiles.h src/kMersProcessing.h src/DBG.h
	$(CC) -o src/CONSENT-correction.o -c src/CONSENT-correction.cpp $(CFLAGS) -IBMEAN/BOA/

CONSENT-polishing: alignmentPiles.o reverseComplement.o kMersProcessing.o CONSENT-polishing.o DBG.o main.o
	$(CC) -o bin/CONSENT-polishing src/main.o src/kMersProcessing.o src/reverseComplement.o src/alignmentPiles.o src/CONSENT-polishing.o src/DBG.o BMEAN/bmean.o BMEAN/utils.o BMEAN/BOA/align_lpo2.o  BMEAN/BOA/align_lpo_po2.o  BMEAN/BOA/align_score.o  BMEAN/BOA/black_flag.o  BMEAN/BOA/buildup_lpo.o  BMEAN/BOA/create_seq.o  BMEAN/BOA/fasta_format.o  BMEAN/BOA/heaviest_bundle.o  BMEAN/BOA/lpo_format.o  BMEAN/BOA/lpo.o   BMEAN/BOA/msa_format.o  BMEAN/BOA/numeric_data.o  BMEAN/BOA/remove_bundle.o  BMEAN/BOA/seq_util.o  BMEAN/BOA/stringptr.o BMEAN/Complete-Striped-Smith-Waterman-Library/src/*.o $(LDFLAGS)

CONSENT-polishing.o: src/CONSENT-polishing.cpp src/CONSENT.h src/CONSENT-polishing.h src/alignmentPiles.h src/kMersProcessing.h src/DBG.h
	$(CC) -o src/CONSENT-polishing.o -c src/CONSENT-polishing.cpp $(CFLAGS) -IBMEAN/BOA/	

reverseComplement.o: src/reverseComplement.cpp
	$(CC) -o src/reverseComplement.o -c src/reverseComplement.cpp $(CFLAGS)

alignmentPiles.o: src/alignmentPiles.cpp src/Alignment.h src/reverseComplement.h
	$(CC) -o src/alignmentPiles.o -c src/alignmentPiles.cpp $(CFLAGS)

kMersProcessing.o: src/kMersProcessing.cpp
	$(CC) -o src/kMersProcessing.o -c src/kMersProcessing.cpp $(CFLAGS)


DBG.o: src/DBG.cpp src/reverseComplement.h
	$(CC) -o src/DBG.o -c src/DBG.cpp $(CFLAGS)

#BMEAN.o: BMEAN/bmean.cpp
#	$(CC) -o BMEAN/bmean.o -c BMEAN/bmean.cpp $(CFLAGS) -IBMEAN/BOA/

utils.o: BMEAN/utils.cpp
	$(CC) -o BMEAN/utils.o -c BMEAN/utils.cpp $(CFLAGS)

main.o: src/main.cpp src/CONSENT.h
	$(CC) -o src/main.o -c src/main.cpp $(CFLAGS)

clean:
	rm src/*.o bin/CONSENT-correction bin/CONSENT-polishing bin/explode
