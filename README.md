RUNNING:

>> fusermount -u tmp1

>> gcc fs.c -c `pkg-config fuse --cflags --libs`

>> gcc structure_functions.c -c

>> gcc structure_functions.o fs.o `pkg-config fuse --cflags --libs` -o fs

>> ./fs -f tmp1/


File System Using FUSE

About FUSE

FUSE (Filesystem in Userspace) is an interface for userspace programs to export a filesystem to the Linux kernel.The FUSE project consists
of two components: the fuse kernel module (maintained in the regular kernel repositories) and the libfuse userspace library (maintained in 
this repository).libfuse provides the reference implementation for communicating with the FUSE kernel module.
A FUSE file system is typically implemented as a standalone application that links with libfuse. libfuse provides functions to mount the 
file system, unmount it,read requests from the kernel, and send responses back. libfuse offers two APIs: a "high-level", synchronous API,
and a "low-level" asynchronous API. In both cases, incoming requests from the kernel are passed to the main program using callbacks. 
When using the high-level API, the callbacks may work with file names and paths instead of inodes, and processing of a request finishes 
when the callback function returns. When using the low-level API, the callbacks must work with inodes and responses must be sent explicitly
using a separate set of API functions.


What is File System ?

In computing, a file system or filesystem controls how data is stored and retrieved. Without a file system, information placed in a storage
medium would be one large body of data with no way to tell where one piece of information stops and the next begins. By separating the data
into pieces and giving each piece a name, the information is easily isolated and identified. Taking its name from the way paper-based 
information systems are named, each group of data is called a "file". The structure and logic rules used to manage the groups of 
information and their names is called a "file system".
File systems can be used on numerous different types of storage devices that use different kinds of media. The most common storage device
in use today is a hard disk drive. Other kinds of media that are used include flash memory, magnetic tapes, and optical discs. 
In some cases, such as with tmpfs, the computer's main memory (random-access memory, RAM) is used to create a temporary file system for 
short-term use.

The filesystem mainly consists of six main components:

-> I-node bitmap

-> Data block bitmap

-> Node bitmap

-> I-nodes

-> Data blocks

-> Nodes

The bitmaps are being used to check whether a given index is occupied or empty.The I-nodes are the stat structures for our filesystem. 
They store basic information about the file/directory.Data-blocks are the region where the actual data is being stored.  
Data blocks are assigned only for files and not for directories. In this way we are saving memory. Node is the data-structure used to 
implement Tree structure. Each element of the tree is a node.

TREE structure:

The filesystem traversal structure is being implemented using a N-ary Tree.
The root node is the root directory. Each Node can have more than 2 children and each being a file or a directory.
All the children of a node is a linked list and the head being the first child. The parent points only to its first child. 
The child-node points to its next sibling.Each node has an attribute file_type which is differentiates a file and a directory.

WORKING:

The filesystem is initially empty. Once the filesystem is mounted the root directory is being created. Every time we need to create a
file/directory a node is being created in the tree and that node is appended to the appropriate parent or sibling, and hence the tree 
structure is being updated.
For creating either a file or a directory first the availability of the node, inode is checked, followed by the creation of Node and
I-node. In case of directories no data-blocks are allocated. Therefore we are saving memory. In case of files again the availability
of data-blocks is checked and required number of data-blocks are being allocated.
After the successful creation of data-blocks the data is being written onto the blocks.
When a file/directory is to be deleted, the file is searched in the filesystem and in case it is present, the respective bitmaps are set
to empty and the tree structure is updated such that the node is deleted.


PERSISTENCE:

On unmounting the filesystem, the data (metedata + actual data) is being written to an external binary file. The binary file is being
updated every time the get_attribute function is called. Hence the binary file remains up-to date.
On remounting the filesystem the contents are being read from the external binary file and the filesystem structures are being updated
accordingly. The tree structure is regenerated.


