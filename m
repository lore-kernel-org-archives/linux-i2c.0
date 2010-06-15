From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH 4/8]drivers:tmp.c Fix warning: variable 'rc' set but
	not used
Date: Tue, 15 Jun 2010 07:29:44 +0200
Message-ID: <20100615052944.7746.qmail@stuge.se>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com> <1276547208-26569-5-git-send-email-justinmattock@gmail.com> <21331.1276560832@localhost> <4C16E18F.9050901@gmail.com> <9275.1276573789@localhost> <4C16F9FC.2080905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C16F9FC.2080905@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, reiserfs-devel@vger.kernel.org, linux-bluetooth@vger.kernel.org, debora@linux.vnet.ibm.com, linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Justin P. Mattock wrote:
> > *baffled* Why did you think that would work? transmit_cmd()s signature
> > has 4 parameters.
> 
> I have no manual in front of me. Did a quick google, but came up with 
> (no hits) info on what that function does. grep showed too many entries 
> to really see why/what this is.

Check out the tool cscope. (Or kscope, if you prefer a GUI.)


//Peter
