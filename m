Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B09C433FE
	for <linux-i2c@archiver.kernel.org>; Fri, 18 Mar 2022 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiCROQJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiCROQJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Mar 2022 10:16:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF824F290;
        Fri, 18 Mar 2022 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647612890; x=1679148890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wKbKU3t/6V4styBQS4BOZSgHoaD4VUBToUeJ31eWRsM=;
  b=pUcogFltzvahRZCGVmfPEy/mg9HFPij+Jxnaq6nd5Z7Qkcw5QMf6EcGn
   7WGcJOQN54XBTd5uYQbkYhQuDAB3NHNWIU2ry9dEzVMANWbllFJCiVTrF
   SXglLzq+IgWejTpoDBxqb/fYykVHJBJGp5sE7OFOd2mIaC3h4XcjCTqVN
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Mar 2022 07:14:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:14:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 07:14:48 -0700
Received: from [10.110.88.130] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 18 Mar
 2022 07:14:48 -0700
Message-ID: <7f376c43-3a37-4972-f614-180968ec59eb@quicinc.com>
Date:   Fri, 18 Mar 2022 07:14:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] i2c: add tracepoints for I2C slave events
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Wolfram Sang <wsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
References: <20220308163333.3985974-1-quic_jaehyoo@quicinc.com>
 <20220318100249.3eb97c10@gandalf.local.home>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <20220318100249.3eb97c10@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Steven,

On 3/18/2022 7:02 AM, Steven Rostedt wrote:

[...]

>> +	TP_printk("i2c-%d a=%03x %s [%*phD]",
>> +		__entry->adapter_nr, __entry->addr,
>> +		__print_symbolic(__entry->event,
>> +				 { I2C_SLAVE_READ_REQUESTED,	"RD_REQ" },
>> +				 { I2C_SLAVE_WRITE_REQUESTED,	"WR_REQ" },
>> +				 { I2C_SLAVE_READ_PROCESSED,	"RD_PRO" },
>> +				 { I2C_SLAVE_WRITE_RECEIVED,	"WR_RCV" },
>> +				 { I2C_SLAVE_STOP,		"  STOP" }),
> 
> For the above to be useful for perf and trace-cmd (user space tools) you
> will need to export them with:
> 
> TRACE_DEFINE_ENUM(I2C_SLAVE_READ_REQUESTED);
> TRACE_DEFINE_ENUM(I2C_SLAVE_WRITE_REQUESTED);
> TRACE_DEFINE_ENUM(I2C_SLAVE_READ_PROCESSED);
> TRACE_DEFINE_ENUM(I2C_SLAVE_WRITE_PROCESSED);
> TRACE_DEFINE_ENUM(I2C_SLAVE_STOP);
> 
> before the TRACE_EVENT()

Got it. I'll add it to v3.

Thanks,
Jae
