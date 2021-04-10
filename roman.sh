#!/bin/bash
# Author: kontelk

# Μετατρέπει έναν δεκαδικό αριθμό σε ρωμαϊκό και αντίστροφα
# Δέχεται ως όρισμα ένα αλφαριθμητικό και εμφανίζει 
# το αποτέλεσμα στην οθόνη.

# μετατροπή του δεκαδικού σε ρωμαϊκό
convertDecToRoman(){
    #clear
    echo -n "Ο δεκαδικός $decvalue αντιστοιχεί στον ρωμαϊκό:  "
    #echo ""
    while [ $decvalue -ne 0 ] # Όσο είναι μικρότερο του μηδενός αφαιρώ ποσότητες και 
    do                        # δημιουργώ τον ρωμαϊκο
        if [ $decvalue -ge 1000 ]; then
            echo -n "M"
            decvalue=$((decvalue-1000))
        elif [ $decvalue -ge 900 ]; then
            echo -n "CM"
            decvalue=$((decvalue-900))
        elif [ $decvalue -ge 500 ]; then
            echo -n "D"
            decvalue=$((decvalue-500))     
        elif [ $decvalue -ge 400 ]; then
            echo -n "CD"
            decvalue=$((decvalue-400))           
        elif [ $decvalue -ge 100 ]; then
            echo -n "C"
            decvalue=$((decvalue-100))
        elif [ $decvalue -ge 90 ]; then   
            echo -n "XC"
            decvalue=$((decvalue-90))           
        elif [ $decvalue -ge 50 ]; then   
            echo -n "L"
            decvalue=$((decvalue-50))      
        elif [ $decvalue -ge 40 ]; then
            echo -n "XL"
            decvalue=$((decvalue-40))              
        elif [ $decvalue -ge 10 ]; then
            echo -n "X"
            decvalue=$((decvalue-10))        
        elif [ $decvalue -ge 9 ]; then
            echo -n "IX"
            decvalue=$((decvalue-9))
        elif [ $decvalue -ge 5 ]; then
            echo -n "V"
            decvalue=$((decvalue-5))
        elif [ $decvalue -ge 4 ]; then
            echo -n "IV"
            decvalue=$((decvalue-4))
        elif [ $decvalue -ge 1 ]; then
                
            if [ $decvalue -eq 3 ]; then
                echo -n "III"
                break
            elif [ $decvalue -eq 2 ]; then
                echo -n "II"
                break
            elif [ $decvalue -eq 1 ]; then
                echo -n "I"
                break
            fi
            
        fi            
    done
    echo " "
}

# μετατροπή του ρωμαϊκού σε δεκαδικό
convertRomanToDec(){
    roman_number=$(echo $decvalue | tr a-z A-Z)
    # Ελέγχω ότι ο αριθμός δεν έχει λάθος χαρακτήρες
    [[ "${roman_number//[IVXLCDM]/}" == "" ]] || \
        { echo O ρωμαϊκός αριθμός ${roman_number} περιέχει λάθος χαρακτήρες ; exit 1 ;}

    # Τα μετατρέπω όλα σε Ι, αφαιρώ τις αλλαγές γραμμής και μετράω
    # τους χαρακτήρες Ι
    decimal_number=$(
        echo ${roman_number} |
        sed 's/CM/DCD/g' |
        sed 's/M/DD/g' |
        sed 's/CD/CCCC/g' |
        sed 's/D/CCCCC/g' |
        sed 's/XC/LXL/g' |
        sed 's/C/LL/g' |
        sed 's/XL/XXXX/g' |
        sed 's/L/XXXXX/g' |
        sed 's/IX/VIV/g' |
        sed 's/X/VV/g' |
        sed 's/IV/IIII/g' |
        sed 's/V/IIIII/g' |
        tr -d '\n' |
        wc -m
    )
    echo " Ο ρωμαϊκός αριθμός ${roman_number} είναι ο δεκαδικός αριθμός ${decimal_number}"
}

# Εδώ είναι το κύριο μέρος του προγράμματος. Από εδώ ξεκινάω το πρόγραμμα και 
# καλώ ανάλογα με το τι μου έδωσε ο χρήστης σαν input την αντίστοιχη συνάρτηση για μετατροπή
echo "Πρόγραμμα μετατροπής αριθμού από δεκαδική μορφή σε ρωμαϊκή και αντίστροφα."
read -p "Δώσε έναν θετικό αριθμό σε δεκαδική ή σε ρωμαϊκή γραφή: " decvalue
#if grep -Eq "^[0-9]+$" <<< "${decvalue}"; then  # εάν είναι θετικός αριθμός (α' τρόπος)
if [[ "${decvalue}" =~ ^[0-9]+$ ]]; then         # εάν είναι θετικός αριθμός (β' τρόπος)
    convertDecToRoman
elif grep -Eq "^-" <<< "${decvalue}"; then
    echo "Δώσατε αρνητικό αριθμό!"
else convertRomanToDec      # Εάν δεν είναι αριθμός κάλεσε την convertRomanToDec
fi
read -p "Πάτησε Enter για έξοδο από το πρόγραμμα." z
