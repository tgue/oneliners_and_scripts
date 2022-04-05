#runs PSMC on single samples according to MSMC's guide 
# you need a file "bamfiles" which contains the path to the bamfiles you want to run PSMC for
#uses a recombination rate/mutation rate ratio of 0.88 (for humans) 


module load bioinfo-tools samtools

for bamfile in $(cat bamfiles)
do
ref=/proj/snic2020-2-10/private/Data/Human/Ancient/ref_seqs/hs37d5.fa

indid=$(basename $bamfile | cut -d"." -f1 )


for chr in {1..22}
do
samtools depth -r $chr $bamfile | awk '{sum += $3} END {print sum / NR}'
done >$indid.covbychr


basefile=$(basename $bamfile .fa.bam)

for chr in {1..22}
do
meancov=$( sed "${chr}q;d" $indid.covbychr )

sbatch <<EOF
#!/bin/bash
#SBATCH -A snic2022-22-101
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 4-0:00:00
#SBATCH -J msmc.${indid}_$chr
#SBATCH -e msmc.${indid}_$chr.er

module load bioinfo-tools samtools 
module load bcftools
module load  python/3.9.5

samtools mpileup -q 20 -Q 20 -C 50 -u -r $chr -f $ref $bamfile | bcftools call -c -V indels | ./bamCaller.py $meancov ${basefile}_chr${chr}_mask.bed.gz | 
gzip -c > ${basefile}_chr${chr}.vcf.gz 

module load  python/3.9.5

./generate_multihetsep.py --mask=${basefile}_chr${chr}_mask.bed.gz  \
                          --mask=hs37d5_chr$chr.mask.bed.gz \
                          ${basefile}_chr${chr}.vcf.gz >$basefile.chr${chr}.multihetsep > $indid.chr$chr.multihetsep

EOF
done
done



for bamfile in $(tail -n3 bamfiles)
do
indid=$(basename $bamfile | cut -d"." -f1 )
basefile=$(basename $bamfile .fa.bam)

sbatch <<EOF
#!/bin/bash
#SBATCH -A snic2022-22-101
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 4-0:00:00
#SBATCH -J msmc.${indid}_$chr
#SBATCH -e msmc.${indid}_$chr.er
module load bioinfo-tools msmc

msmc -r 0.88  -o $indid.output $indid.chr{1..22}.multihetsep
EOF
done
#by Nina Hollfelder
