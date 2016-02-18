String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

var thmenvs = ["theorem", "lemma", "remark", "proposition", "definition"];
for ( var i in thmenvs ){
    env = thmenvs[i];
    $( "div." + env ).each(function( index ){
	$( this ).html("<p><b> " + env.capitalize() + " " + (index+1) + ":</b></p> " + $( this ).html() );
	label = $( this ).attr( "id" );
	$("a[href$=\"" + label + "\"]").each(function (){
            $( this ).text(String(index+1));
	});
    });
}
