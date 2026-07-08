# RFCs
Specification documents for code that needs developing, requests for peer review, general memos, etc.

## How to Use This Repository

If you are not a member of the Ingenium LiDAR team, this repository will likely not be useful to you. You may read it if you like, but it will probably not be worth your time. 

### Reading This Repository

This repo is your task list--it defines most of what you're allowed to be doing while you're clocked in. 

#### If you do not have a coding project at the moment:

Look through the Request For Software folder! Pick the highest priority project that you feel you can accomplish, and add your initials after the `-` in the title to indicate that you're working on it (sometimes, it may be appropriate for multiple people to work on one project, but don't add your initials to someone else's unless you've already arranged to cowork with them in person).

#### If you have some "down time", or you're waiting on something:

First, tell your team leadership the situation that is holding you back. Then, take a look at the Request For Review folder, and see if there are any review requests out there that you are able to review. Check over the relevant code in accordance with the review instructions, and put your feedback in the RFR (it's also polite to email it to the people involved in the project). Once an RFR has been fully resolved and the code mentioned in it is in production, the RFR may be deleted.

#### If you have an idea for an optimization or additional feature:

Write an Idea! Ideas can be as detailed or as not detailed as you like. Anyone can write literally anything work-related in there at any time. Put down as much as is in your head--maybe someday an architect will come along, approve your idea, and write an RFS based on it!

Ideas that sound smart at the time but ultimately prove less-than-ideal can be moved to the Dropped Ideas folder, which should include an explanation of why the idea in question was dropped for future teams to read. Note that this should only be used for Ideas which the team would never consider implementing for the forseeable future--if you think it might actually be worth doing at some point in the next few years, leave it in Ideas!

#### If you're an architect with spare time:

Read through the Ideas folder! If there's anything in there that you think is worth putting out an RFS for, write the RFS! (Of course, adjust the priority field on the RFS accordingly, to prevent overprioritization of fun but unecessary projects).

#### If you're an architect with not enough time:

Write a Request for Investigation to outsource research tasks to other teammembers. Other teammembers should not begin researching on the clock until an architect specifically and personally assigns them to an RFI. 

### Writing an RFS

Write a Request For Software when you are in the role of "software architect". Any RFS that is written must meet the following criteria:

1. It must be complete--it must clearly and unambiguously define all inputs, outputs, and side effects to the desired program, and should include a program architecture sketch. If you do not have a really clear idea of what *exactly* the script needs to do, it should go in an Idea instead.

2. It must be very detailed. If you are writing an RFS, it should contain every relevant detail you think might possibly be helpful. 

3. It must be API-defined--you should have already consulted with everyone whose program may interface with yours, and you should have collaboratively clearly defined exactly what one expects to output and what the other expects to input. 

4. It must be approved by team leadership. An RFS is a formal request for a teammember to go out and write this code, *now!*. An RFS is not
the place for drafting or thinking out loud. That's what Ideas are for. It is an official statement saying "this program needs to exist", and as such, requires leadership approval. 

### Writing an RFR

Write a Request For Review when you have completed a task specified in an RFS. Once you have a draft of your software that you consider minimally functional, you should write an RFR about it to ask a teammember to check over your code. A second pair of eyes can be very helpful!


### Writing an RFI

Write a Request For Investigation when you're the architect and you want a tool that does a very specific thing, but don't know which tool or tools exist to do that thing. Write very clearly and specifically define the information you want in as much detail as you can.