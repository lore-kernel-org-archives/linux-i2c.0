From: Sebastian Frias <sf84@laposte.net>
Subject: Re: True Parallel Port Interface for Bit-banging?
Date: Tue, 25 Oct 2016 16:56:47 +0200
Message-ID: <580F72AF.9070900@laposte.net>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpoutz25.laposte.net ([194.117.213.100]:53431 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752089AbcJYO4w (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Oct 2016 10:56:52 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 197001040F4
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 16:56:49 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 0ABDD1046D3
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 16:56:49 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 0674D1040F4
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 16:56:49 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
        by lpn-prd-vrin003 (Postfix) with ESMTP id E870248E078
        for <linux-i2c@vger.kernel.org>; Tue, 25 Oct 2016 16:56:48 +0200 (CEST)
In-Reply-To: <20161025142935.GA2875@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

On 10/25/2016 04:29 PM, Wolfram Sang wrote:
>> The virtualisation idea is not good then?
> 
> It is not that. I think good old DOSEMU could do that. Bit-Banging ports
> can be timing critical, though, and in this department virtualization
> solutions often fail.
> 

Thanks.
I understand your point, but I'm guessing that the big-banging routine (or the
protocol to be used) should be time-independent in order to run on different
real HW PCs, right? Otherwise a 386DX and a 486DX2 could behave differently,
right?

Or is the "timing issue" you talk about more related to unpredictable
latencies due to the way the SW virtualisation works?

What about emulation? Do you think emulation would be more predictable?
