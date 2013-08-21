# Basserts

## Overview

 Basserts is a library of assertion functions for use within unit tests.   Yes, yes.  I know.  
 It sounds crazy that we might want to test bash code.  But because bashum makes it so easy
 to modularize bash code, it doesn't take very long before we have projects that are 
 thousands of lines long.  

 As our programs grow in size and complexity, so too does the risk of bugs.  In order to minimize
 that risk, we should test!  Basserts aims to facilitate that.
 
## Files 

### /lib/basserts/assert.sh

This is the ONLY file in basherts.  It contains the following methods:
	
* assert 
* assert\_equals
* assert\_not\_equals
* assert\_matches
* assert\_failure
* assert\_true
* assert\_false
* assert\_contains
* assert\_empty
