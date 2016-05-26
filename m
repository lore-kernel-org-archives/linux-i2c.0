From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V3 1/2] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
Date: Fri, 27 May 2016 03:31:13 +0530
Message-ID: <002201d1b79a$22862bc0$67928340$@codeaurora.org>
References: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org> <1464164212-11377-2-git-send-email-sricharan@codeaurora.org> <20160526184805.GC1614@katana>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160526184805.GC1614@katana>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, nkaje@codeaurora.org, absahu@codeaurora.org, linux-i2c@vger.kernel.org, galak@codeaurora.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi,

>> sg_set_buf expects that the buf parameter passed in should be from
>> lowmem and a valid pageframe. This is not true for pages from
>> dma_alloc_coherent which can be carveouts, hence the check fails.
>
>OK, given you mean dma_pool_alloc here, the check fails for the
>pageframe because of the pool? Is my understanding correct?
>
Yes right. Since those are carveouts, there is no valid pageframe,
 so the check fails.

>> Change allocation of sg buffers from dma_coherent memory to kzalloc
>> to fix the issue.
>
>But why can you drop the coherency?
>
 The coherency is not dropped here. dma_map/unmap used
 makes the buffer coherent before passing it to
 dmaengine. Previously it was not required.
 I can add this in description if its not clear.

 >> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>>  		}
>>  	}
>>
>> +	idx = 0;
>> +
>
>This looks like an unrelated change.
    Ha, wrong. This should have been in a separate patch. This was to fix a
    initialization issue in dma mode. Sorry, should not have been here, will
    move it to out.

Regards,
 Sricharan
