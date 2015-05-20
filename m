From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: maintain parport
Date: Wed, 20 May 2015 09:28:16 -0700
Message-ID: <1432139296.2870.305.camel@perches.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-7-git-send-email-sudipm.mukherjee@gmail.com>
 <CAFLxGvyw+UhHrdbiXCkKefirjiOum2+cNY26zDe2AzAi0hx0ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAFLxGvyw+UhHrdbiXCkKefirjiOum2+cNY26zDe2AzAi0hx0ng@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>, Willy Tarreau <willy@meta-x.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-05-20 at 17:46 +0200, Richard Weinberger wrote:
> On Wed, May 20, 2015 at 5:27 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > Lets give the parport subsystem a proper name and start
> > maintaining the files.
> 
> Excuse me, but usually someone takes over the maintainer role after
> proving that he
> cares for a sub system for a certain period of time.
> Or did I miss something?

MAINTAINERS:85:    Orphan:      No current maintainer [but maybe you could take the
MAINTAINERS-86-                 role as you write your new code].

Parport is an orphan, hasn't had a maintainer since at
least 2.6.12, and has almost no activity minus drive-by
cleanups and new device ID support every once in awhile.

Sudip is writing new code.

If Sudip wants to be a maintainer of parport, assuming
he has the time and resources to give it a go, I think
he should be welcomed to it.

Thanks Sudip.  Best of luck...
