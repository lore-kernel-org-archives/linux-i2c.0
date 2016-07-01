From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Fri, 1 Jul 2016 11:30:28 +0200
Message-ID: <20160701113028.7a47c236@endymion>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
	<20150709165939.GB4744@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55389 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbcGAJoS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 05:44:18 -0400
In-Reply-To: <20150709165939.GB4744@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, linux-i2c@vger.kernel.org

Hi Wolfram, Ellen,

On Thu, 9 Jul 2015 18:59:39 +0200, Wolfram Sang wrote:
> On Fri, May 22, 2015 at 03:14:28PM -0700, Ellen Wang wrote:
> > On a CRC error while using hardware-supported PEC, an additional
> > error bit is set in the auxiliary status register.  If this bit
> > isn't cleared, all subsequent operations will fail, essentially
> > hanging the controller.
> > 
> > The fix is simple: check, report, and clear the bit in
> > i801_check_post().  Also, in case the driver starts with the
> > hardware in that state, clear it in i801_check_pre() as well.
> > 
> > Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
> > ---
> > Update: fix typos in commit message, otherwise the same as v2
> > 
> > This is essentially the patch from Jean Delvare, which handles
> > the polling case while my original version didn't.  (Thank you!
> > Please add appropriate attribution if you wish.)
> > 
> > I tested all the additional code paths by selectively commenting
> > out code: with interrupts, without interrupts, relying on check_pre()
> > to clear CRCE, no clearing of CRCE at all (baseline).
> 
> Jean, any comments or tags to add?

Sorry, this one fell trough the cracks. The patch is good and still
needed. I have tested it successfully on several systems. Wolfram,
please apply it.

Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
