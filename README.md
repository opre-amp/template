# Operációs rendszerek VIMIAB00
# AMP labor
# Jegyzőkönyv
A labor során elvégzendő feladatok kódját ebbe a repositoryba, a feljegyzéseket ebbe a fileba kell feltölteni. Beadás előtt a vonal feletti részeket ki kell törölni. 

A dokumentációhoz képernyőképet hozzáadni a következőképpen lehet (a repositoryban kell lennie a képnek, relatív útvonnallal hivatkozva):

![Sample image](assets/sample.png)

A dokumentáció nyelve elsősorban angol, de akinek ez gondot okoz írhatja magyarul illetve németül (németes csoport) is. A dokumentációs skeleton angol nyelven írodott, de adaptálni lehet más nyelvre amennyiben szükséges.

A git használatához a következő parancsokat szükséges ismerni:
* `git clone <repository url>` leklónolja a githubon lévő repositoryt egy lokális másolatba
* `git add <file>` a következő commithoz hozzáadja a file-t
* `git commit -m "<message>"` létrehoz egy \<message\> nevű commit-ot
* `git push origin master` a lokális változtatásokat felmásolja a szerverre
* `git pull origin master` a szerveren lévő új változásokat lemásolja a lokális repositoryba

---

# Documentation for the AMP Laboratory

## Toolchains

**Did both of the toolchains work? Was this expected? Why?**

Answer

## Image Preparation

**What is the name of the real-time kernel? What release and version is it?**

Answer

**What devices are present in the booted system as part of the device tree?**

Answer

**Which parameter has to be set to only allow 3 CPUs in the system?**

Answer

**The mem=nn\[KMG\] parameter can be used to limit the RAM usage of the system. What is KMG, and how to set it to 512 Megabytes?**

Answer

**What do the existing parameters mean in the boot.cmd file?**

Answer

## GPIO

**At which bus address does the I/O block start?**

Answer

**Where can we reach it from software running without an OS?**

Answer

**Where can we reach it from software running on top of an OS running in kernel mode?**

Answer

**Which register (name and bus address) is responsible for selecting the GPIO function of pins #14, #15 and #16? Which bits?**

Answer

**Which registers are the corresponding SET, CLEAR and LEVEL registers (name and bus address)?**

Answer

### Task 1

Short specification of the program

Design decisions if necessary 

Summary of the development

### Task 7

Short specification of the program

Design decisions if necessary 

Summary of the development

**Using ${CROSS_BARE}nm metal.elf determine where each of the functions are placed by the linker. What is the entry point’s address?**

Answer

**What is the SET address of the 3rd core’s 3rd mailbox?**

Answer

**What is the CLEAR address of the 3rd core’s 3rd mailbox?**

Answer

**Which is readable?**

Answer

## Kernel Modules

**How long was the time difference between two ‘printk’ statements?**

Answer

### Task 2

Short specification of the program

Design decisions if necessary 

Summary of the development

### Task 8

Short specification of the program

Design decisions if necessary 

Summary of the development

## Latency Measurements

**How long is one cycle of the fpga in (nano)seconds?**

Answer

### Results

**Normal kernel, no stress**

* min:
* max:
* avg:
* var:


**Normal kernel, with stress**

* min:
* max:
* avg:
* var:


**Normal kernel, with stress and low priority**

* min:
* max:
* avg:
* var:


**Normal kernel, with stress and high priority**

* min:
* max:
* avg:
* var:


**Normal kernel, with stress running in a kernel module**

* min:
* max:
* avg:
* var:


**RT kernel, with stress and low RT priority**

* min:
* max:
* avg:
* var:


**RT kernel, with stress and high RT priority**

* min:
* max:
* avg:
* var:


**RT kernel, with low RT stress and high RT priority**

* min:
* max:
* avg:
* var:


**RT kernel, with high RT stress and low RT priority**

* min:
* max:
* avg:
* var:


**AMP system, no stress**

* min:
* max:
* avg:
* var:


**AMP system, with high RT stress**

* min:
* max:
* avg:
* var:

**Summary**

Summarize the latencies in a histogram-type diagram. 

Diagram:

![Sample graph](assets/sample-graph.png)

---

# Mini-OHV
Ez már nem része az értékelendő munkának.

## Miben lehetne jobb a labor?

Válasz néhány szóban

## Mi tetszett a laborban?

Válasz néhány szóban

## Mi nem tetszett a laborban?

Válasz néhány szóban

## Mi volt túlmagyarázva (miből kellett volna kevesebb iránymutatás)?

Válasz néhány szóban

## Miből kellett volna több iránymutatás?

Válasz néhány szóban

## Mennyire érzed hasznosnak a labor anyagát?

Válasz néhány szóban