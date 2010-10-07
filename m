From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] i2c: Fix Kconfig dependencies
Date: Thu, 07 Oct 2010 15:37:40 +0200
Message-ID: <4CADCD24.90507@suse.cz>
References: <1286199093-3576-1-git-send-email-mmarek@suse.cz>	<20101004180346.59b10af7@endymion.delvare>	<20101004223020.GA14702@sepie.suse.cz>	<20101005100349.73914574@endymion.delvare>	<20101005155631.GA9399@sepie.suse.cz> <20101007152442.1901a630@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101007152442.1901a630@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 7.10.2010 15:24, Jean Delvare wrote:
> OK, I've applied this patch. I doubt I can get it in Linus' tree before
> 2.6.36 is release though, my previous pull request wasn't even
> acknowledged yet.

OK, thanks.


> Then we will have to discuss about a better solution with Roman Zippel,
> because what we have now is all but elegant. Will you start the
> discussion, or should I?

Roman has been absent for a year and half :(. The closest thing to a
kconfig maintainer is currently me...

Michal
