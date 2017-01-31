From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: busses: constify i2c_algorithm structures
Date: Tue, 31 Jan 2017 15:22:49 +0100
Message-ID: <20170131152249.07265d1d@endymion>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752122AbdAaOW5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Jan 2017 09:22:57 -0500
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, ludovic.desroches@atmel.com, wsa@the-dreams.de, sonic.zhang@analog.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, patrice.chotard@st.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com

On Fri, 27 Jan 2017 23:36:17 +0530, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> (...)

I have vague memories that I tried to do the same long ago and it
didn't work back then. But I can't no longer remember the details, and
today it seems just fine to do it.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
