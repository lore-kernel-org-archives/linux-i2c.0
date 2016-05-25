From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/5] i2c-i801: Move PEC handling into
 i2c_block_transaction()
Date: Wed, 25 May 2016 14:00:15 +0200
Message-ID: <20160525140015.163e5431@endymion>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
	<1453223377-20608-4-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34407 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbcEYMAS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 25 May 2016 08:00:18 -0400
In-Reply-To: <1453223377-20608-4-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

Hi Corey,

On Tue, 19 Jan 2016 11:09:35 -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> PEC is only used on real block transactions, moving it into the block
> transaction code allows removal of some if statements and the proper
> setting of SMBAUXCTL.  PEC was being set in the byte-by-byte block
> transaction, though it wasn't valid in that situation.

First thing to do would be check what the hardware actually supports.
The driver is indeed only handling PEC properly for one-shot block
transactions. That does not mean the hardware itself doesn't support
PEC in other cases. I'm almost certain that PEC is supported for
non-block transactions (except SMBus Quick Command.) Not sure about
byte-by-byte block transactions, but this should be tested first.

Cleaning up broken code makes little sense, as we may have to undo some
of the cleanups to get the driver to work properly.

And no, I don't think "PEC was being set in the byte-by-byte block
transaction". What was being set is the "automatically append CRC" bit
in AUX_CTL, but my understanding is that this bit has no effect when
SMBHSTCNT_PEC_EN itself isn't set.

-- 
Jean Delvare
SUSE L3 Support
