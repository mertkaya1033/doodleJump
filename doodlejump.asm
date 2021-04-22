#####################################################################
#
#
# Student: Mert Kaya
#
#
#
# CSC258H5S Fall 2020 Assembly Final Project
 # University of Toronto, St. George
 
# Bitmap Display Configuration:
 # - Unit width in pixels: 8
 # - Unit height in pixels: 8
 # - Display width in pixels: 256
 # - Display height in pixels: 256
 # - Base Address for Display: 0x10008000 ($gp)
 #
 # Which milestone is reached in this submission?
 # - Milestone 5
 #
 # Which approved additional features have been implemented?
 # 1. (Milestone 4a)One point is added to the score for every new platform the doodler jumps on.
 # 2. (Milestone 4b)When the game is over, a game over text is displayed
 # 3. (Milestone 4b)The player can restart the game by pressing 's'
 # 4. (Milestone 5c)
 #	rocket suit: every 10 points a new orange platform will appear. When the doodler jumps onto that platform, it will gain 
 #		a rocket suit which will boost the doodler 3 platforms. The rocket suit looks like brown wings.
 #	spring:	     every 13 points, a new blue platform will appear. That platform contains a spring which will launch the
 #		doodler 2 platforms when the doodler lands on the spring platform.
 # 5. (Milestone 5d)The background is a gradient whose colour changes as the doodler climbs up
 # 6. (Milestone 5e) 
 #		ii.
 #			- When the player reaches 10 points, they will see "nice!" on the top left corner
 #			- When the player reaches 100 points, they will see "wow!" on the top left corner
 # 			- When the player reaches 500 points, they will see a PogO face on the top left corner which will stay there
 #		      for the rest of the game
#####################################################################

.data
	# statics
	displayAddress:		.word	0x10008000
	dispBoundary:		.word	0x1f		# 0x1f = 31 = 0111111
	normalJumpBoundary:	.word	0x0f
	rocketJumpBoundary:	.word	0x2f
	springJumpBoundary:	.word	0x1f
	numberZero:		.word	0x000000, 0x000000, 0x000000, -2, 0x000000,-1, 0x000000, -2, 0x000000, -1, 0x000000, -2,0x000000,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3 
	numberOne:		.word	-1, 0x000000, -1, -2, 0x000000, 0x000000, -1, -2, -1, 0x000000, -1, -2, -1, 0x000000, -1, -2, 0x000000,0x000000,0x000000,-3
	numberTwo:		.word	0x000000, 0x000000, 0x000000, -2, -1, -1, 0x000000, -2, 0x000000, 0x000000, 0x000000, -2,0x000000,-1, -1, -2, 0x000000,0x000000,0x000000,-3 
	numberThree:		.word	0x000000, 0x000000, 0x000000, -2, -1, -1, 0x000000, -2, 0x000000, 0x000000, 0x000000, -2,-1,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3
	numberFour:		.word	0x000000, -1, 0x000000, -2, 0x000000, -1, 0x000000, -2, 0x000000, 0x000000, 0x000000, -2,-1,-1, 0x000000, -2, -1,-1, 0x000000,-3
	numberFive:		.word	0x000000, 0x000000, 0x000000, -2, 0x000000, -1, -1, -2, 0x000000, 0x000000, 0x000000, -2,-1,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3 
	numberSix:		.word	0x000000, 0x000000, 0x000000, -2, 0x000000, -1, -1, -2, 0x000000, 0x000000, 0x000000, -2,0x000000,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3 
	numberSeven:		.word	0x000000, 0x000000, 0x000000, -2, -1, -1, 0x000000, -2, -1, -1, 0x000000, -2,-1,-1, 0x000000, -2, -1,-1,0x000000,-3
	numberEight:		.word	0x000000, 0x000000, 0x000000, -2, 0x000000, -1, 0x000000, -2, 0x000000, 0x000000, 0x000000, -2,0x000000,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3 
	numberNine:		.word	0x000000, 0x000000, 0x000000, -2, 0x000000, -1, 0x000000, -2, 0x000000, 0x000000, 0x000000, -2,-1,-1, 0x000000, -2, 0x000000,0x000000,0x000000,-3 
	numbers:		.word 	0:10
	gameOverText:		.word	0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,-1,-1,-1,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-2,0xff0000,-1,-1,-1,-1,0xff0000,-1,-1,0xff0000,-1,0xff0000,0xff0000,-1,0xff0000,0xff0000,-1,0xff0000,-1,-1,-1,-2,0xff0000,-1,0xff0000,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,-1,0xff0000,-1,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-2,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,-1,0xff0000,-1,0xff0000,-1,-1,-1,-2,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,-1,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-2,-2,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,-1,-1,-1,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-2,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,-1,0xff0000,-1,0xff0000,-1,-1,-1,-1,0xff0000,-1,-1,0xff0000,-2,0xff0000,-1,-1,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,0xff0000,0xff0000,0xff0000,-2,0xff0000,-1,-1,0xff0000,-1,-1,0xff0000,-1,0xff0000,-1,-1,0xff0000,-1,-1,-1,-1,0xff0000,-1,0xff0000,-2,0xff0000,0xff0000,0xff0000,0xff0000,-1,-1,-1,0xff0000,-1,-1,-1,0xff0000,0xff0000,0xff0000,0xff0000,-1,0xff0000,-1,-1,0xff0000,-3
	wow:			.word	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0x0000ff,-2, 0x0000ff,-1,-1,-1,0x0000ff,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-1,-1,-1,0x0000ff,-1,0x0000ff,-2,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-2,-1,0x0000ff,-1,0x0000ff,-1,-1,0x0000ff,0x0000ff,0x0000ff,-1,-1,0x0000ff,-1,0x0000ff,-1,-1,0x0000ff,-3
	face:			.word	0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,-2,0x0000ff,-1,-1,-1,-1,-1,-1,0x0000ff,-2,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,-1,0x0000ff,-2,0x0000ff,-1,-1,-1,-1,-1,-1,0x0000ff,-2,0x0000ff,-1,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-2,0x0000ff,-1,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-2,0x0000ff,-1,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-2,0x0000ff,-1,-1,-1,-1,-1,-1,0x0000ff,-2,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,0x0000ff,-3
	nice:			.word	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-2,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-1,-1,-1,0x0000ff,-2,0x0000ff,-1,0x0000ff,-1,-1,-1,0x0000ff,-1,-1,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-2,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,-1,-1,0x0000ff,-2,0x0000ff,-1,0x0000ff,-1,0x0000ff,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,0x0000ff,0x0000ff,-1,0x0000ff,-3
	doodlerPic:		.word	-1, -1,-1,0xffb399, -2, -1, -1,0xffb399,0xffb399,0xffb399,-1,-1,-2,-1,-1,0xffb399,-1,0xffb399,-1,-1,-3
	doodlerRocketPic:	.word	-1, -1,-1,0xffb399, -2, 0xD2691E, 0xD2691E,0xffb399,0xffb399,0xffb399,0xD2691E,0xD2691E,-2,0xD2691E,-1,0xffb399,-1,0xffb399,-1,0xD2691E,-3
	
	normalPlatformPic:	.word	0x80ff80,0x80ff80,0x80ff80,0x80ff80,0x80ff80,0x80ff80,0x80ff80,0x80ff80,-3
	rocketPlatformPic:	.word	0xffd24d,0xffd24d,0xffd24d,0xffd24d,0xffd24d,0xffd24d,0xffd24d,0xffd24d,-3
	springPlatformPic:	.word	0x4d4dff,0x4d4dff,0x4d4dff,0x4d4dff,0x4d4dff,0x4d4dff,0x4d4dff,0x4d4dff,-3
	
	backgroundDiv:		.word 	1
	# dynamics 
	jumpBoundary:		.word	0xf
	platformX: 		.word	12, 0, 0	# stores the x positions of the platforms
	platformY:		.word	31, 0, 0	# stores the y positions of the platforms 
	platformTypes:		.word	0:3
	isNextPlatformRocket:	.word	0
	isNextPlatformSpring:	.word	0
	isDoodlerOnRocket:	.word	0
	isDoodlerOnSpring:	.word	0
	countToRocket:		.word	10
	countToSpring:		.word	13
	doodleX:		.word	14
	doodleY:		.word	28
	jumpDist: 		.word	0
	currentPlatform:	.word	0
	score:			.word	0
	backgroundColour:	.word 	0xccf1ff
	backgroundIncrement:	.word	-256		# - 0x000100
	backgroundCounter:	.word	0		# if divisible by 4, increment backgroundColour
.text

main:	
	lw $t0, displayAddress
	addi $t6, $zero, 3	# $t6 = num platforms
	
	li $t4, 14
	sw $t4, doodleX
	
	li $t4, 28
	sw $t4, doodleY
	
	sw $zero, jumpDist
	li $t4, 499		# change this to 9, 99 or 499 to see the achievements (all you need to do is jump onto the next platform :)
	sw $t4, score
	li $t4, 12
	sw $t4, platformX
	
	li $t4, 31
	sw $t4, platformY
	
	la $t5, numbers
	
	la $t4, numberZero
	sw $t4, 0($t5)
	addi $t5, $t5, 4 
	la $t4, numberOne
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberTwo
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberThree
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberFour
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberFive
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberSix
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberSeven
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberEight
	sw $t4, 0($t5)
	addi $t5, $t5, 4
	la $t4, numberNine
	sw $t4, 0($t5)
	
	li $t4, 0xccf1ff
	sw $t4, backgroundColour
	li $t4, -256
	sw $t4, backgroundIncrement
	li $t4, 0
	sw $t4, backgroundCounter
	la $t4, normalPlatformPic
	la $t5, platformTypes
	sw $t4, 0($t5)
	sw $t4, 4($t5)
	sw $t4, 8($t5)
	
	li $t4, 0xf
	sw $t4, jumpBoundary
	
	la $t4, platformX
	la $t5, platformY
	sw $t5, currentPlatform
	jal genPlats
main_gameplay:
	lw $t8, 0xffff0000
	la $ra, afterKeyIn
	beq $t8, 1, keyboard_input
afterKeyIn:
	lw $t8, score
	jal updateGame
	
	add $t7, $zero, $zero
	addi $t8, $t0, -4	# $t9 stores the unit location
	addi $t9, $t0, 4092	# $t8 stores last unit's location + 4 (32x32 grid x 4 bytes of colour data)
	jal clear		# clear the bitmap: make every unit white
	
	lw $t8, score
	li $a0, 1
	li $a1, 1
	beq $t8, 10, displayNice
	beq $t8, 100, displayWow
	bge $t8, 500, displayFace
	j continueGame
displayNice:
	la $a2, nice
	jal displayPic
	j continueGame
displayWow:
	la $a2, wow
	jal displayPic
	j continueGame
displayFace:
	la $a2, face
	jal displayPic
	j continueGame
continueGame:	
	jal displayPlats
	jal paintDoodle

displayScore:
	addi $t8, $zero,  28
	lw $s1, score
	li $s2, 10
displayScoreLoop:
	div $s1, $s2
	mfhi $s3
	mflo $s1
	
	li $s4, 4
	mult $s4, $s3
	mflo $s4
	la $s5, numbers
	add $s5, $s5, $s4
	lw $s5, 0($s5)
	
	add $a0, $zero, $t8
	addi $a1, $zero, 1
	add $a2, $s5, $zero
	jal displayPic
	
	addi $t8, $t8, -4
	bgt $s1, $zero, displayScoreLoop
	
	li $v0, 32
	li $a0,50
	syscall
	
	j main_gameplay

gameOver:
	addi $a0, $zero, 6
	addi $a1, $zero, 10
	la $a2, gameOverText
	jal displayPic
gameOverLoop:
	lw $t8, 0xffff0000
	bne $t8, 1, skipRestartCheck
	lw $t2, 0xffff0004
	beq $t2, 0x73, main
	beq $t2, 0x71, END
skipRestartCheck:
	li $v0, 32
	li $a0,50
	syscall
	j gameOverLoop


updateGame:
	
	# check if game is over
	lw $s1, doodleY
	li $s2, 28
	bgt $s1, $s2, gameOver
	
	
	lw $s1, jumpDist
	
	#start checking for platforms
	lw $s2, jumpBoundary	#check jumpBoundary
	blt $s1, $s2, updateObjectPos	# check if doodler is still jumping, skip platform check
	sw $zero, isDoodlerOnRocket
	sw $zero, isDoodlerOnSpring
	lw $s2, normalJumpBoundary
	sw $s2, jumpBoundary
	sw $s2, jumpDist
	addi $t6, $zero, 3 		# total num of platforms
	la $t1, platformX
	la $t2, platformY
	la $t4, platformTypes
	
platformCheck:				# platform collision check
	# if platformY !== doodleY + 3 skip to the next platform check
	lw $t3, 0($t2)
	lw $s3, doodleY
	addi $s3, $s3, 3
	bne $t3, $s3, nextPlatformInCheck
	
	# else: if doodleX + 3 < platformX || doodleX > platformX + 8
	lw $t3, 0($t1)
	lw $s3, doodleX			# $s3 = doodleX
	addi $s4, $s3, 3		# $s4 = doodleX+3
	lw $s2, dispBoundary
	and $s4, $s4, $s2
	
	
	ble $s3, $t3, nextPlatformCollisionCheck
	addi $t3, $t3, 8
	bge $s3, $t3, nextPlatformCollisionCheck
	j jump
	
nextPlatformCollisionCheck:
	lw $t3, 0($t1)
	ble $s4, $t3, nextPlatformInCheck
	addi $t3, $t3, 8
	bge $s4, $t3, nextPlatformInCheck
	j jump

jump:
	# if program has came this far, doodler is on a platform, stop jumping (or start a new jump)
	sw $zero, jumpDist
	lw $s1, currentPlatform
	beq $s1, $t2, updateObjectPos
	sw $t2, currentPlatform
	lw $s1, score
	addi $s1, $s1, 1
	sw $s1, score
	lw $s2, normalJumpBoundary
	sw $s2, jumpBoundary
	lw $s2, 0($t4)
	la $s3, rocketPlatformPic
	
	bne $s2, $s3, springCheck	
	li $s2, 1
	sw $s2, isDoodlerOnRocket
	lw $s2, rocketJumpBoundary
	sw $s2, jumpBoundary
	
springCheck:
	lw $s2, 0($t4)
	la $s3, springPlatformPic
	bne $s2, $s3, nextRocketCheck
	li $s2, 1
	sw $zero, isDoodlerOnRocket
	sw $s2, isDoodlerOnSpring
	lw $s2, springJumpBoundary
	sw $s2, jumpBoundary

nextRocketCheck:
	lw $s2, countToRocket
	div $s1, $s2
	mfhi $s4
	bnez $s4, nextSpringCheck
	li $s1, 1
	sw $s1, isNextPlatformRocket
	j updateObjectPos

nextSpringCheck:
	lw $s2, countToSpring
	div $s1, $s2
	mfhi $s4
	bnez $s4, updateObjectPos
	li $s1, 1
	sw $s1, isNextPlatformSpring
	j updateObjectPos
	
nextPlatformInCheck:
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	addi $t4, $t4, 4
	addi $t6, $t6, -1
	bgt $t6, $zero, platformCheck
	
updateObjectPos:
	lw $s1, jumpDist
	
	lw $s2, jumpBoundary
	beq $s1, $s2, incrementY
	
	lw $s3, doodleY
	li $s4, 12			# represents the position at which the platforms will start moving down
	
	addi $s5, $zero, 3
	la $t1, platformX
	la $t2, platformY
	la $t3, platformTypes
	bne $s3, $s4, skipBackgroundDown
	
	# if code has come this far, that means the background needs to move down:
	lw $t9, backgroundCounter
	addi $t9, $t9, 1
	sw $t9, backgroundCounter
	
	lw $s6, backgroundDiv
	div $t9, $s6
	mfhi $t9
	bne $t9, $zero, skipBackgroundDown
	
	lw $s6, backgroundColour
	lw $s7, backgroundIncrement
	
	add $s6, $s6, $s7
	sw $s6, backgroundColour
	beq $s6, 0xccccff, incRedMovePlatDown
	beq $s6, 0xffccff, decBlueMovePlatDown
	beq $s6, 0xffcccc, incGreenMovePlatDown
	beq $s6, 0xffffcc, decRedMovePlatDown
	beq $s6, 0xccffcc, incBlueMovePlatDown
	beq $s6, 0xccffff, decGreenMovePlatDown
	j skipBackgroundDown
incRedMovePlatDown:
	li $s7, 0x010000
	sw $s7, backgroundIncrement
	j skipBackgroundDown
decBlueMovePlatDown:
	li $s7, -1		# - 0x000001
	sw $s7, backgroundIncrement
	j skipBackgroundDown
incGreenMovePlatDown:
	li $s7, 0x000100
	sw $s7, backgroundIncrement
	j skipBackgroundDown	
decRedMovePlatDown:
	li $s7, -65536		# - 0x010000
	sw $s7, backgroundIncrement
	j skipBackgroundDown
incBlueMovePlatDown:
	li $s7, 0x000001
	sw $s7, backgroundIncrement
	j skipBackgroundDown
decGreenMovePlatDown:
	li $s7, -256		# - 0x000100
	sw $s7, backgroundIncrement
	j skipBackgroundDown
	
skipBackgroundDown:
	beq $s3, $s4, movePlatDown
	
	addi $s1, $s1, 1
	sw $s1, jumpDist
	
	addi $s3, $s3, -1
	sw $s3, doodleY
	jr $ra
	

incrementY:
	lw $s5, doodleY
	addi $s5, $s5, 1
	sw $s5, doodleY
	jr $ra

movePlatDown:
	lw $s1, 0($t1)			# current platformX
	lw $s2, 0($t2)			# current platformY
	lw $s3, dispBoundary
	addi $s2, $s2, 1
	blez $s2, nextPlatformMoveDown
	and $s2, $s2, $s3
	# if platform is not at the end of the display, move onto next platform
	bne $s2, $zero, nextPlatformMoveDown	
	
	# else, give a random X pos to platform and set its Y appropriately
	lw $s1, isDoodlerOnRocket
	beq $s1, $zero, skipAddScoreOnRocket
	lw $s1, score
	addi $s1, $s1, 1
	sw $s1, score
	j genXForNewPlat
skipAddScoreOnRocket:
	lw $s1, isDoodlerOnSpring
	beq $s1, $zero, genXForNewPlat
	lw $s1, score
	addi $s1, $s1, 1
	sw $s1, score
	j genXForNewPlat
genXForNewPlat:
	
	# generate random x pos for the platform
	li $v0, 42
	li $a0, 0
	li $a1, 24		# 32-8=24 since the platform is going to be 4 units wide
	syscall	
	
	add $s1, $a0, $zero		# store the first platfom's X in memory
	la $s4, normalPlatformPic
	sw $s4, 0($t3)
	lw $s4, isNextPlatformRocket
	beq $s4, $zero, skipChangePlatform
	la $s4, rocketPlatformPic
	sw $s4, 0($t3)
	sw $zero, isNextPlatformRocket
	j skipChangeSpring
skipChangePlatform:
	lw $s4, isNextPlatformSpring
	beq $s4, $zero, skipChangeSpring
	la $s4, springPlatformPic
	sw $s4, 0($t3)
	sw $zero, isNextPlatformSpring
skipChangeSpring:
	# get the current index	
	bne $s5, 3, nextPlatformY
	lw $s2, 8($t2)
	addi $s2, $s2, -11
	j nextPlatformMoveDown
	
nextPlatformY:
	lw $s2, -4($t2)
	addi $s2, $s2, -12
	
nextPlatformMoveDown:
	sw $s1, 0($t1)
	sw $s2, 0($t2)
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	addi $t3, $t3, 4
	addi $s5, $s5, -1
	bne $s5, $zero, movePlatDown
	
	lw $s1, jumpDist
	addi $s1, $s1, 1
	sw $s1, jumpDist
	jr $ra
	
genPlats:
	addi $t6, $t6, -1
	beq $t6, $zero, RETURN
	lw $t8, 0($t5)
	addi $t4, $t4, 4
	addi $t5, $t5, 4
	
	# generate random x pos for the platform
	li $v0, 42
	li $a0, 0
	li $a1, 24		# 32-8=24 since the platform is going to be 4 units wide
	syscall	
	
	sw $a0, 0($t4)		# store the first platfom's X in memory
	
	# add gap 
	addi $t8, $t8, -12
	sw $t8, 0($t5)		# store the first platfom's Y in memory
	j genPlats
	
keyboard_input:
	addi $sp, $sp, -4 	# move the stack pointer 4 bytes lower
	sw $ra, 0($sp)		# store the linked register
	
	lw $t2, 0xffff0004
	beq $t2, 0x6a, respond_j
	beq $t2, 0x6b, respond_k
	beq $t2, 0x71, END
	
	lw $ra, 0($sp)		# get the linked register back
	addi $sp, $sp, 4	# deallocate stack 
	jr $ra			# jump to the instruction after func call
	
respond_j:
	#lw $s1, isDoodlerOnRocket
	#bnez $s1, RETURN
	
	lw $s1, doodleX
	lw $t7, dispBoundary
	
	addi $s1, $s1, -1	# decrement x
	and $s1, $s1, $t7
	sw $s1, doodleX
	
	jr $ra
	
respond_k:
	#lw $s1, isDoodlerOnRocket
	#bnez $s1, RETURN
	
	lw $s1, doodleX
	lw $t7, dispBoundary
	
	addi $s1, $s1, 1	# decrement x
	and $s1, $s1, $t7
	sw $s1, doodleX
	
	jr $ra

clear: 
	addi $sp, $sp, -4 	# move the stack pointer 4 bytes lower
	sw $ra, 0($sp)		# store the linked register
	
	lw $t1, backgroundColour	# $t1 stores the blue colour code
	lw $t2, backgroundIncrement
	add $t3, $zero, $zero
	lw $t4, backgroundDiv
	sll $t4, $t4, 5
	jal PAINTALL		# paint all units white
	
	lw $ra, 0($sp)		# get the linked register back
	addi $sp, $sp, 4	# deallocate stack 
	jr $ra			# jump to the instruction after func call

PAINTALL:
	beq $t8, $t9, RETURN
	addi $t3, $t3, 1
	div $t3, $t4
	mfhi $t5
	bne $t5, $zero, contPaintAll
	
	add $t1, $t1, $t2
	beq $t1, 0xccccff, incRedPaintAll
	beq $t1, 0xffccff, decBluePaintAll
	beq $t1, 0xffcccc, incGreenPaintAll
	beq $t1, 0xffffcc, decRedPaintAll
	beq $t1, 0xccffcc, incBluePaintAll
	beq $t1, 0xccffff, decGreenPaintAll
	j contPaintAll
incRedPaintAll:
	li $t2, 0x010000
	j contPaintAll
decBluePaintAll:
	li $t2, -1		# - 0x000001
	j contPaintAll
incGreenPaintAll:
	li $t2, 0x000100
	j contPaintAll	
decRedPaintAll:
	li $t2, -65536		# - 0x010000
	j contPaintAll
incBluePaintAll:
	li $t2, 0x000001
	j contPaintAll
decGreenPaintAll:
	li $t2, -256		# - 0x000100
	j contPaintAll

contPaintAll:
	sw $t1, 0($t9)		# paint the color on the given position
	addi $t9, $t9, -4	# increment $t8
	j PAINTALL

paintDoodle:
	addi $sp, $sp, -4 	# move the stack pointer 4 bytes lower
	sw $ra, 0($sp)		# store the linked register
	
	lw $t0, displayAddress 
	lw $a0, doodleX
	addi $a0, $a0, -2
	lw $a1, doodleY
	
	lw $s1, isDoodlerOnRocket
	la $a2, doodlerPic
	
	beq $s1, $zero, skipToPaintNormalDoodler
	la $a2, doodlerRocketPic
skipToPaintNormalDoodler:
	jal displayPic
	
	lw $ra, 0($sp)		# get the linked register back
	addi $sp, $sp, 4	# deallocate stack 
	jr $ra

	
displayPlats:
	addi $sp, $sp, -4 	# move the stack pointer 4 bytes lower
	sw $ra, 0($sp)		# store the linked register
	
	la $t4, platformX	# $t4 stores the memory address of platformX
	la $t5, platformY	# $t5 stores the memory address of platformY
	la $t7, platformTypes
	addi $t6, $zero, 3	# $t6 stores the number of platforms
GENPLATLOOP:
	lw $a0, 0($t4)
	lw $a1, 0($t5)
	lw $a2, 0($t7)
	bltz $a1, skipPlatform
	jal displayPic
skipPlatform:
	addi $t6, $t6, -1
	addi $t4, $t4, 4
	addi $t5, $t5, 4
	addi $t7, $t7, 4
	bnez $t6, GENPLATLOOP
	
	lw $ra, 0($sp)		# get the register address
	addi $sp, $sp, 4	# deallocate stack 
	jr $ra			# jump to the instruction after func call
	
displayPic:
	# $a0 represents the x pos of the picture
	# $a1 represents the y pos of the picture
	# $a2 represents the address of the pic
	# $a3 represents the current x
	add $a3, $zero, $zero
	lw $t0, displayAddress
displayPicRec:			# rec => recursion
	lw $t1, 0($a2)		# value of the pic
	beq $t1, -1, displayPicSkipEnd
	beq $t1, -2, displayPicNextLine
	beq $t1, -3, RETURN
	
	addi $t2, $zero, 4
	mult $a0, $t2
	mflo $t3
	
	addi $t2, $zero, 128
	mult $a1, $t2
	mflo $t2
	
	add $t3, $t2, $t3
	add $t3, $t0, $t3
	sw $t1, 0($t3)	
displayPicSkipEnd:
	addi $a0, $a0, 1
	addi $a2, $a2, 4
	addi $a3, $a3, 1
	j displayPicRec
displayPicNextLine:
	sub $a0, $a0, $a3
	addi $a1, $a1, 1
	addi $a2, $a2, 4
	add $a3, $zero, $zero
	j displayPicRec
	
RETURN:	jr $ra
END:
	li $v0, 10		#terminate the program gracefully
	syscall
