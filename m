From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.28, round 1
Date: Tue, 14 Oct 2008 23:25:36 +0200
Message-ID: <20081014232536.716f149d@hyperion.delvare>
References: <20081014180333.55d9004a@hyperion.delvare>
	<20081014.114609.74110219.davem@davemloft.net>
	<20081014215137.2d039afb@hyperion.delvare>
	<20081014.131331.115267742.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753692AbYJNV0R@vger.kernel.org>
In-Reply-To: <20081014.131331.115267742.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Dave,

On Tue, 14 Oct 2008 13:13:31 -0700 (PDT), David Miller wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Date: Tue, 14 Oct 2008 21:51:37 +0200
> 
> > Except for one i2c-i801 patch which depends on a pci_ids update, all I
> > have in my queue was part of this pull request. So, no, I don't have
> > your bus addressing nor sparc I2C driver bits. Honestly, I can't even
> > remember getting such patches from you. Do you have some reference I
> > can search for? If not, please send the patches to the i2c list again.
> 
> Here are URLs to the I2C list patch postings I made, you were CC:'d on
> every single one of them:
> 
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004714.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004716.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004717.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004713.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004715.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004719.html
> http://lists.lm-sensors.org/pipermail/i2c/2008-August/004718.html
> 
> And I include each posting here as an attachment as well.

Ah, these patches. Yes, they are in my inbox. No, I didn't have the
time to review them when you posted them, sorry, and then I forgot
about them.

> Please apply.

Well, I can't apply them without giving them at least a quick review.
I'll try to do that in the next few days so that the patches can be
part of my second i2c pull request to Linus for 2.6.28. That is, if I
don't see anything that needs more discussions.

-- 
Jean Delvare
