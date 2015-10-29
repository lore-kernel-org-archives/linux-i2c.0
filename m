From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: i2c: mark also subdirectories as maintained
Date: Thu, 29 Oct 2015 10:15:53 -0700
Message-ID: <1446138953.2757.176.camel@perches.com>
References: <1446103548-2217-1-git-send-email-wsa@the-dreams.de>
	 <1446127903.2757.163.camel@perches.com> <20151029155258.GB22218@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:35566 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965264AbbJ2RP4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Oct 2015 13:15:56 -0400
In-Reply-To: <20151029155258.GB22218@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

On Thu, 2015-10-29 at 16:52 +0100, Wolfram Sang wrote:
> > +	   The scripts/get_maintainer.pl tool has a quirk about subdirectories.
> > +	   If the file pattern is for a directory, then any subdirectories of
> > +	   the parent directory should also be specified.  For instance:
> > +		F:	drivers/i2c/
> > +		F:	drivers/i2c/*/
> > +	   Otherwise, the scripts/get_maintainer.pl tool by default will use
> > +	   git history to add additional people that have "Signed-off-by:"
> > +	   style signatures on commits to files in those subdirectories.
> 
> I'd be fine with the change. The patch description should probably state
> why fixing the tool is not worth it.

Not worth it vs inappropriate (arch/arm, etc...)

Maybe the wording around "quirk" could be improved or expanded.

Any suggestions?
