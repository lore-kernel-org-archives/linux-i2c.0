From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: I2C-Octeon: Use common error handling code in octeon_i2c_probe()
Date: Thu, 26 Oct 2017 07:00:36 +0200
Message-ID: <20e16385-afab-1d3d-b682-04589568850e@users.sourceforge.net>
References: <73affb84-9cdd-9f5c-b96a-5a392739e789@users.sourceforge.net>
 <77df0e64-bf30-b6d0-b28b-ddb3c0574dfe@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:63024 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdJZFBJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Oct 2017 01:01:09 -0400
In-Reply-To: <77df0e64-bf30-b6d0-b28b-ddb3c0574dfe@caviumnetworks.com>
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>, linux-i2c@vger.kernel.org
Cc: Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

> NAK.  We don't need any more Markus Elfring spam.

Why do you not like another update suggestion for this use case?


>> Add a jump target so that a specific error message is stored only once
>> at the end of this function implementation.
> 
> Please read C standard about duplicate literal strings to see
> why this is a completely misleading and false statement.

* I proposed to adjust the position for one function call, didn't I?

* Do you care for a bit of code reduction?

* Do you prefer to use an optimisation option like “-fmerge-constants”
  (instead of integrating the shown small change)?

Regards,
Markus
