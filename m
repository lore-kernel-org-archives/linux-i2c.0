From: Willy Tarreau <w@1wt.eu>
Subject: Re: [RFC PATCH] checkpatch: check for 2 or more spaces around
 assignment of a declaration
Date: Thu, 21 May 2015 07:48:06 +0200
Message-ID: <20150521054806.GB8344@1wt.eu>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150520154907.GB2001@katana> <20150520171452.GA9069@sudip-PC>
 <20150520195918.1c150979@endymion.delvare>
 <1432170126.20840.22.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1432170126.20840.22.camel@perches.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Willy Tarreau <willy@meta-x.org>, Andrew Morton <akpm@linux-foundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tim Waugh <tim@cyberelk.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 06:02:06PM -0700, Joe Perches wrote:
> Perhaps space aligned declarations should have some
> checkpatch --strict warning for 2 or more spaces
> around any assignment of the declaration.
> 
> 	int a   = 1;		// 2+ spaces before =
> 	int b	=  2;		// 2+ spaces after =
> 	int c	=	3;	// uses tabs around =, no warning
> 	int d		= 4;	// uses 2 tabs before =, no warning

FWIW, in my own code I've stopped using tabs for this and replaced
them with spaces. Tabs are fine *before* code but they completely
mangle the display for people using different tab sizes, or even
when reading diffs, because they heavily depend on the number of
characters *before* them while what you want is to ensure that
what is *after* is on a fixed position.

I would even go further and report warnings when tabs are used after
text.

Tabs after text were very useful in ASM editors in the past because
it was possible to define 3 fixed positions (mnemonic, operands,
comments) and that was the primary purpose of tabs. But in todays
editors, tabs do not mean "jump to next position" but "add between
1 and 8 to the current position" which doesn't make sense at all
if what preceeds can be larger than 8 (which is most often the case
in C code).

Willy
