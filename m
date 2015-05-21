From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] checkpatch: check for 2 or more spaces around
 assignment of a declaration
Date: Wed, 20 May 2015 18:02:06 -0700
Message-ID: <1432170126.20840.22.camel@perches.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
	 <20150520154907.GB2001@katana> <20150520171452.GA9069@sudip-PC>
	 <20150520195918.1c150979@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520195918.1c150979@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Tim Waugh <tim@cyberelk.net>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-05-20 at 19:59 +0200, Jean Delvare wrote:
> On Wed, 20 May 2015 22:44:52 +0530, Sudip Mukherjee wrote:
> > On Wed, May 20, 2015 at 05:49:07PM +0200, Wolfram Sang wrote:
> > > On Wed, May 20, 2015 at 08:57:00PM +0530, Sudip Mukherjee wrote:
> > > >  static struct parport_driver i2c_parport_driver = {
> > > > -	.name	= "i2c-parport",
> > > > -	.attach	= i2c_parport_attach,
> > > > -	.detach	= i2c_parport_detach,
> > > > +	.name		= "i2c-parport",
> > > > +	.match_port	= i2c_parport_attach,
> > > > +	.detach		= i2c_parport_detach,
> > > > +	.devmodel	= true,
> > > 
> > > Minor nit: I prefer to not use tabs but a single space after the struct
> > > member names. Less hazzle in the future and still readable IMO.
> >
> > It was having space originally. I changed that into tab as it was
> > looking good with them as aligned.
> 
> As the driver maintainer, I am fine with both unaligned or tab-aligned.
> Space-aligned as I did originally was not a good idea, I admit.

Perhaps space aligned declarations should have some
checkpatch --strict warning for 2 or more spaces
around any assignment of the declaration.

	int a   = 1;		// 2+ spaces before =
	int b	=  2;		// 2+ spaces after =
	int c	=	3;	// uses tabs around =, no warning
	int d		= 4;	// uses 2 tabs before =, no warning
	
Something like:
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 89b1df4..8f9d26f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3902,6 +3902,13 @@ sub process {
 			    "multiple assignments should be avoided\n" . $herecurr);
 		}
 
+# check for space aligned declarations
+		if ($line =~ /^.\s*(?:$Declare|$DeclareMisordered)\s*$Ident {2,}=\s*(?:$Lval|$Constant|$String)/ ||
+		    $line =~ /^.\s*(?:$Declare|$DeclareMisordered)\s*$Ident\s*= {2,}(?:$Lval|$Constant|$String)/) {
+			CHK("SPACING",
+			    "Avoid multiple space assigments - prefer a single space or tabs\n" . $herecurr);
+		}
+
 ## # check for multiple declarations, allowing for a function declaration
 ## # continuation.
 ## 		if ($line =~ /^.\s*$Type\s+$Ident(?:\s*=[^,{]*)?\s*,\s*$Ident.*/ &&
