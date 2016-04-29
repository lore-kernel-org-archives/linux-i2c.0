From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
Date: Fri, 29 Apr 2016 13:26:16 +0200
Message-ID: <572344D8.6060401@st.com>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana> <5722107C.3000600@st.com>
 <20160428145720.GA1541@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56218 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752176AbcD2L0s (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Apr 2016 07:26:48 -0400
In-Reply-To: <20160428145720.GA1541@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, patrice.chotard@st.com, lee.jones@linaro.org, linux-i2c@vger.kernel.org, Frederic Pillon <frederic.pillon@st.com>



On 04/28/2016 04:57 PM, Wolfram Sang wrote:
>> The trick is to switch to SPI mode, 9 bits words and write a 0,
>> so that 9 clock pulses are generated.
> Heh. As long as it works :) But as you said, it really needs a comment.
>
:)
I didn't faced the problem myself, but it looks good with an oscilloscope,
and a customer reported it to work.

Peter, will you resend with adding the explanations I provided as comment?

Thanks in advance,
Maxime
