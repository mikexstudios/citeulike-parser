import re

def verify(s):
	"""Takes a string and validates it to work out whether it's an ISBN or not"""
	# Remove any spurious characters
	s = re.sub(r'[^0-9xX]', '', s).upper().strip()
	
	l = len(s)
	
	if l==10:
		if verify_10(s):
			return s
	elif l==13:
		if verify_13(s):
			return s

	# It's not the right length to be an ISBN
	return False

def hunt(s):
	"""Hunts through a string and yields things which look
	like ISBNs"""
	
	# ISBN-13s
	for regexp in [r'(?:[^0-9]|^)((?:[0-9]-*){12}[0-9X])(?:[^0-9X]|$)',
				   r'(?:[^0-9]|^)((?:[0-9]-*){9}[0-9X])(?:[^0-9X]|$)']:
		for match in re.finditer(regexp, s):
			candidate = match.group(1)
			if verify(candidate):
				yield candidate.replace("-","")

def verify_10(s):
	sum = 0
	for (i, digit) in enumerate(int(c) for c in s[:-1]):
		sum += (i+1) * digit
	comp_checksum = sum % 11
		
	observed_checksum = s[-1]
	if observed_checksum=='X':
		observed_checksum=10
	else:
		observed_checksum=int(observed_checksum)
		
	return comp_checksum == observed_checksum

def verify_13(s):
	raw = sum ([int(i) * int(j) for (i,j) in zip(s[:-1], "13" * 7)])
	comp_checksum = (10 - (raw % 10)) % 10
	observed_checksum = s[-1]
	if observed_checksum=='X':
		observed_checksum=10
	else:
		observed_checksum=int(observed_checksum)
	return comp_checksum == observed_checksum
