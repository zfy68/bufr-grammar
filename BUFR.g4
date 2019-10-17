grammar BUFR;

template: expr (SPACE expr)*;

expr: (
		element_descriptor
		| sequence_descriptor
		| operator_descriptor_expr
	)
	| replication_descriptor (SPACE replication_descriptor)* SPACE (
		element_descriptor
		| sequence_descriptor
		| operator_descriptor_expr
	);

element_descriptor:
	F_EL SPACE (X_PARTS | X_031) SPACE (
		Y_PARTS
		| Y_000
		| Y_001
		| Y_002
		| Y_011
		| Y_012
		| Y_021
		| Y_031
	)
	| data_present_indicator;

operator_descriptor_expr:
	operator_descriptor
	| (operator_descriptor SPACE associated_field_significance);

operator_descriptor:
	F_OP SPACE (X_PARTS | X_031) SPACE (
		Y_PARTS
		| Y_000
		| Y_001
		| Y_002
		| Y_011
		| Y_012
		| Y_021
		| Y_031
	);

sequence_descriptor:
	F_SEQ SPACE (X_PARTS | X_031) SPACE (
		Y_PARTS
		| Y_000
		| Y_001
		| Y_002
		| Y_011
		| Y_012
		| Y_021
		| Y_031
	);

replication_descriptor:
	fixed_replication_descriptor
	| delayed_replication_expr;

fixed_replication_descriptor:
	F_REP SPACE (X_PARTS | X_031) SPACE (
		Y_PARTS
		| Y_001
		| Y_002
		| Y_011
		| Y_012
		| Y_021
		| Y_031
	);
//{System.out.println("Replication factor: " + $Y_021ULL_Z.text);};

delayed_replication_expr:
	delayed_replication_descriptor SPACE delayed_descriptor_replication_factor;

delayed_replication_descriptor:
	F_REP SPACE (X_PARTS | X_031) SPACE Y_000;

// (('000') | ('001') |('002') |('011') | ('012') | ('021')| ('031')) 
/*
 data_description_operator_qualifier: delayed_descriptor_replication_factor |
 associated_field_significance | data_present_indicator;
 */

delayed_descriptor_replication_factor:
	F_EL SPACE X_031 SPACE (
		Y_000
		| Y_001
		| Y_002
		| Y_011
		| Y_012
	);

associated_field_significance: F_EL SPACE X_031 SPACE Y_021;

data_present_indicator: F_EL SPACE X_031 SPACE Y_031;

F_EL: ('0');
F_REP: ('1');
F_OP: ('2');
F_SEQ: ('3');

Y_000: ('000');
Y_001: ('001');
Y_002: ('002');
Y_011: ('011');
Y_012: ('012');
Y_021: ('021');
Y_031: ('031');

Y_PARTS: ('0') ('0') ('3' .. '9')
	| ('010')
	| ('01') ('2' .. '9')
	| ('020')
	| ('02') ('2' ..'9')
	| ('030')
	| ('03') ('2' ..'9')
	| ('0') ('4' .. '9') ('0' .. '9')
	| ('1') ('0' .. '9') ('0' .. '9')
	| ('2') ('0' .. '4') ('0' .. '9')
	| ('2') ('5') ('0' .. '5');

SPACE: ' ';

X_031: '31';

X_PARTS: ('0' .. '2') ('0' .. '9')
	| '30'
	| ('3') ('2' .. '9')
	| ('4' .. '5') ('0' .. '9')
	| ('6') ('0' .. '3');

WS: [\r\n\t]+ -> skip;