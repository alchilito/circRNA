import sys

for l in sys.stdin:
	l = l.rstrip('\n')
	try:
		t = int(l[0])
		print 'chr'+l
	except ValueError:
		print l
