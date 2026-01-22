Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94B3168F6;
	Thu, 22 Jan 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088592; cv=none; b=hW/KvzRigDyoThxcSzEwm3wKS7ZQF1PlAkekRxLqpQTBUkoEA1PAyQ5KJ4D9CtMnZ9qszpWnglp0Fxf/b0fLisE1Vk7L15pLiefdpWHjg19PbEMCSmgh7qwLX6fxy8WZGhhGz3GEJa5lkTPX7fCsJjXqC9S8CSSEUKzAba4Gsuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088592; c=relaxed/simple;
	bh=dHOomvwMgUYonHGR4+bNHTFuhpp2uGohANKWGrEs938=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSxP0J1Q9ZUE5kfcwirkS1NeT3qW/3mD2VcwOLht/qxNykYN+FdNtcK6kjVvO0OdbtqFCes3Q524vAMuPB+xli4V0augU6aaKmMFlftvr9Frcyb2Ijl7S57VlDpWSc6zRqFlLAcRxAHhVLU7QDUbtJAK+RBk9RP8whdPgUr4Pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeH7Jo5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeH7Jo5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0423CC116C6;
	Thu, 22 Jan 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769088591;
	bh=dHOomvwMgUYonHGR4+bNHTFuhpp2uGohANKWGrEs938=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeH7Jo5uBVoiWhfxIEAWhg8K8SUZ3/JO5W2uGJ0SEVVmUlWhVw67SIvNSEAGo/2Xe
	 QNNKzQeALwmPiY5j6O7B+swPrxG/yFH87d4WC6lOVSbxUc8uL9vyBuDvHCvqRhedX1
	 HB/5VzlhENFCN6L7Kj5ly5qbpSJSYYkmPxpwHEozoQInzyXLHFwnIIKdyZ/YPW8XiT
	 ww8QVcocTNR56CYHtFe/jOm3w9FLIRDjIip8xsXEZ+YctoeHh0gPRfN0YgDC/+JRAX
	 6MeA6oWXF+hWxGHRN4F+BfUGzlaXJ8PIYsumje8WC68Yf/C0hjuZosnZFs7PPlmsd+
	 kOWx4SfZGxorg==
Date: Thu, 22 Jan 2026 14:29:48 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 1/6] i2c: designware: Optimize flag reading in
 i2c_dw_read()
Message-ID: <aXImLrvsLBExAX4f@zenone.zhora.eu>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-1-0e34d6d9455c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-i2c-dw-v5-1-0e34d6d9455c@bootlin.com>

Hi Benoit,

On Tue, Jan 20, 2026 at 10:28:01AM +0100, Benoît Monin wrote:
> Optimize the i2c_dw_read() function by reading the message flags only
> once per message, rather than for every byte.
> 
> The message flags are accessed both in the outer loop and the inner loop,
> so move the declaration of the local flags variable to the outer loop.
> 
> The message index is only modified by the outer loop, so reading the
> flags in the inner loop was always getting the same value.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>

This patch has already been applied. If you are going to respin,
please take it off.

Andi
