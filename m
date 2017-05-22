From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: [PULL REQUEST] i2c for 4.12
Date: Mon, 22 May 2017 23:37:25 +0200
Message-ID: <9868e872-1e5c-ce61-31fc-3088caaafc4e@mni.thm.de>
References: <20170519204014.jumojwrdw6lfnycw@ninjato>
 <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
 <20170522201421.zq6ao54uzubjfiiy@ninjato>
 <CA+55aFx2hDWoiQn2S=wHv7AQHvkq+D38EhVu67qbrHdhyGw6Mg@mail.gmail.com>
 <CA+55aFymRrdZO-ASyZSgq4Da28fGJOSd3R-idok_L7NJdTGa0Q@mail.gmail.com>
 <20170522210423.rikepe5crem43wzp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout2.fh-giessen.de ([212.201.18.46]:50720 "EHLO
        mout2.fh-giessen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934097AbdEVVth (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 17:49:37 -0400
Received: from mx2.fh-giessen.de ([212.201.18.41])
        by mout2.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
        id 1dCv14-000E86-Nn
        for linux-i2c@vger.kernel.org; Mon, 22 May 2017 23:37:26 +0200
Received: from mailgate-2.its.fh-giessen.de ([212.201.18.14])
        by mx2.fh-giessen.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <tobias.johannes.klausmann@mni.thm.de>)
        id 1dCv14-005FeG-KZ
        for linux-i2c@vger.kernel.org; Mon, 22 May 2017 23:37:26 +0200
In-Reply-To: <20170522210423.rikepe5crem43wzp@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

If you find the time, please push it out to master for testing purpose! 
(my touchpad is broken as well: 9d6408433019bfae15e2d0d5f4498c4ff70b86c0 
- i2c: designware: don't infer timings described by ACPI from clock rate)


Thanks,

Tobias Klausmann


On 5/22/17 11:04 PM, Wolfram Sang wrote:
>> Confirmed. Initializing those fields to zero fixes it.
> Thanks!
>
