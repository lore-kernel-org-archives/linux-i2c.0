Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215863;
	b=U73hJgZc5Ks0wY0wycFVqpD7biSbztKLO1rSLUo0Xfk2L3qA90aYtDOiCZp+acjEc/kG
	 7JGz1CVnCTo1SCMXE9yQk6oSILRSzOVF2olNrTxYgP8v6MEAWUHfgcLy1epIc8TOYRZgp
	 bQfidrbcQz6j98djpdzNHH/WNbgPpX/huUmzKJVJDZ0h/aFrttc5UO56CNAbSi/t2MBZf
	 DvnkJAzMjAv1hv9vHew3Zvn12gLlyvBC9viH4aul23tJIpsbbCPHiOIxXFGpV2EED0LQR
	 lSMMpbUX/v6kSdhcsKwasUTF6zzQi41t/NT04F8o2ra0WLfbBiKo46+6LrQw3umUiPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
	b=bGYAtbw6E/zWONieVEk89V6zjelNkUA/grjF2cp0+mxPp08gYhWO6ZUAB6L+kMzX7T6F
	 8aqAsT8O1nZqe6F3DZc72cZ8H891zMCm2pTXpK8vc+sHA6DXmh4ye9b8SqthNKffpC962
	 PmjUk5qoy1KdUyj4FVzS41wuSfsrPIqMCs+5hRZnGphmdR9b327FSs7jBeSiuOSHcmz1K
	 MXb7oMrZCT0Du/CPpgOSR0+GMKasarl3QCyeUR9IF/D4afWw+JwDrOG4BR9NCbthc2loy
	 ERN49Aqf0cpZvy02qUkuphtUoasGq8ILhXjWoo6j/KtsfqB5sNK16d27+v6SB/pUV3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=minyard.net;
	spf=pass smtp.mailfrom=minyard.net;
	dkim=pass header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=gC36719i;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096C606A322
	for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 19:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6096C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=gC36719i
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a6f2825dd6so410091fac.2
        for <linux-i2c@vger.kernel.org>; Wed, 28 Oct 2026 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1793215861; x=1793820661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
        b=gC36719iCpac+J0uMgq776jeOZj6OFfT5UfXAAu8QRjqm8ZgwVM5w6YXhN3q9KyUXc
         UGImKfuKxj2xH2QGxCT0ozcu2XUDWhOrxBvqfGLLunODjP4c9GS11CQx8voF+sRxcalE
         7S4ObHLYVH4+CpL+UZyeET/2rX8tn/qqqm3VZC6LSFoa+343pmRwDGuEC1NWm2iWEhRe
         cHxwobq9jYGveOpMguxfPZVZkJIBsc0Xv6Z1asVJ6kZuWNYhYvqV7Ohyg09+WCESkW5O
         IY/QLHxaICp8xiYXFy2t3R0S49kIPN1px7zdW4RenyjdzgXzlWoklwmhmNFNvuL8z1rH
         x/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215861; x=1793820661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
        b=eGxvEomiLgR+YICqSF9lxYgy8nhTlFbDAD1uTsEGHh3H8LBL8/oM5ajKMv/4Ostfdk
         0SGKOL+uWt/SaEzKWLbdJMxYl/t0K1CUujUFiB2nuGPsiW1YGK7ZeSc3UXRF1tVlKN1J
         3jdZtXhkrlBML8ALH5GldlxTpB4ONLfBdbOBHhQ9DfW6o5yuK6o46QyzPa8+AO8OyUDM
         /mjbkeFHeUYC1zG9zNg5jq936/469ipNRwZl13B6F+f3oe3r74rnvVEfeOwCHjkHVM8r
         IjzjjqTY9CL0oYeLWutNlHuqKPvmIuyBax+vLKuPZU1rpV2kPbzdnaUGdiK5CFIoYvT/
         tocQ==
X-Forwarded-Encrypted: i=1; AKwUvBw47MUWmNyqKXHHs24k20GIBq3lWYN76lzoVSXBmBwS4SHQG1+R+4imqF5/YMzxBuVbVjXdc8gSpN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt5ThtjamVGAdNvVCCqoe8iyG1rvaHHIgjqDSdIz44A4Y8ms2z
	qL0EUvhFdGrARF1zAcZ9ovbBcEX8FRSkNEKbcMs/3/iD8iJAnJF0RL4Wvp/29CS7Jzk=
X-Gm-Gg: AYBFou3/7Qj0tkuzM1E89VC8TzQbUMHBN69pV+etV9MB0j9P8qOm1Q79AUucDZmWIVT
	OpIeh+Mlq7pz5lX/2yJ+calj0QtbJClhijmGJWj5FlefVEz5eC5nXHbEEm617wFd0kXQTDhu/BM
	riRnDmbAl22zJVtKcXKJlLFstkiA+SYuN55QQFDtVT70CZn2TJEkyoPRr1YjaY3NotB+1Dnagbv
	33oP5gzLAlNVDVSS2xxT6pH2zVyKyOBUwqUCn8Y7F++/vlarn9UGvG7NJjDLK9DCCsdAfoQJFBg
	FkrEO00ol6a2qJ7asfuUXG1enjOJ2redM17P1K+9UzorYHPGQOEJFJW7AqQE9JCpLUfJTX1DOey
	mwHskTDhzq4sNsBR4F9FlFiptv7mKdmPbyECZfPes2Ibz78j7agKwCiqa1r5y+PXsj8cbT/bZXd
	Ns+O9+qJ+NlYmeVEgW2pkxKgAsESdHyRlNAsdvnCKpS+pRT9Qz263lA4/t7Cv0m+MR/zb9U3VKv
	pMgFztbMxbSJs0AxH50vJbQfE7fXja2p4U6NVgq+bNTfcXa+PXtbqCplY6dVVLidKdoginzsZwu
	qU9D/QeE5/MLAcxHyQfvG/uFW1P6vHUuY1c6DPPEawAllybtIzHJorr/AyIN1vBvTGzmxXnQ6on
	i2cpTds3RtCOyf9aoZzEK0bq/XCO6MlBlaUMwf/UqdMbBNIDh/C64ePS42jUfyXAZw5PSAx0=
X-Received: by 2002:a05:6870:9e08:b0:45e:54a3:b8ca with SMTP id 586e51a60fabf-4a8bb427d08mr2615315fac.19.1793215861021;
        Wed, 28 Oct 2026 12:31:01 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:2f32:e466:d3ef:5b82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b78de44esm3375499fac.11.2026.10.28.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:31:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:30:56 -0500
From: Corey Minyard <corey@minyard.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/8] ipmi: ssif: use 4-argument
 i2c_smbus_read_block_data()
Message-ID: <auJNcEiVgwCW5D1Y@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-6-19bb97467982@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-6-19bb97467982@gmail.com>

On Sat, Oct 24, 2026 at 07:48:46PM -0700, Dmitry Torokhov wrote:
> Pass the receive buffer capacity to i2c_smbus_read_block_data() in
> ipmi_ssif_thread() via the i2c_size field, and update ssif_i2c_send()
> callers to pass the receive buffer size.
> 
> Update read_response(), do_cmd(), and test_multipart_messages() to
> accept the response buffer length, clamping the transfer size to
> I2C_SMBUS_BLOCK_MAX when reading from the device.

This is in my for-next tree.  It passes all tests.

The reuse of the "size" parameter to ssif_i2c_send() is ok.  That's not
really what it was originally meant for, it was the transaction type,
but it wasn't used, so all is good.

-corey

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 2361103c5edc..9c0aebec2946 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -503,7 +503,7 @@ static int ipmi_ssif_thread(void *data)
>  		} else {
>  			result = i2c_smbus_read_block_data(
>  				ssif_info->client, ssif_info->i2c_command,
> -				ssif_info->i2c_data);
> +				ssif_info->i2c_size, ssif_info->i2c_data);
>  			if (result < 0)
>  				ssif_info->done_handler(ssif_info, result,
>  							NULL, 0);
> @@ -541,7 +541,7 @@ static void start_get(struct ssif_info *ssif_info)
>  
>  	ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
>  		  SSIF_IPMI_RESPONSE,
> -		  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> +		  ssif_info->recv, sizeof(ssif_info->recv));
>  }
>  
>  static void start_resend(struct ssif_info *ssif_info);
> @@ -669,7 +669,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  
>  		ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
>  			 SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> -			 ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> +			 ssif_info->recv, sizeof(ssif_info->recv));
>  		return;
>  	} else if (ssif_info->multi_pos) {
>  		/* Middle of multi-part read.  Start the next transaction. */
> @@ -736,7 +736,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  				  I2C_SMBUS_READ,
>  				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
>  				  ssif_info->recv,
> -				  I2C_SMBUS_BLOCK_DATA);
> +				  sizeof(ssif_info->recv));
>  			return;
>  		}
>  	}
> @@ -1314,12 +1314,15 @@ static void ssif_remove(struct i2c_client *client)
>  	kfree(ssif_info);
>  }
>  
> -static int read_response(struct i2c_client *client, unsigned char *resp)
> +static int read_response(struct i2c_client *client, unsigned char *resp,
> +			 size_t resp_length)
>  {
>  	int ret = -ENODEV, retry_cnt = SSIF_RECV_RETRIES;
>  
>  	while (retry_cnt > 0) {
>  		ret = i2c_smbus_read_block_data(client, SSIF_IPMI_RESPONSE,
> +						min_t(size_t, resp_length,
> +						      I2C_SMBUS_BLOCK_MAX),
>  						resp);
>  		if (ret > 0)
>  			break;
> @@ -1333,7 +1336,7 @@ static int read_response(struct i2c_client *client, unsigned char *resp)
>  }
>  
>  static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
> -		  int *resp_len, unsigned char *resp)
> +		  int *resp_len, unsigned char *resp, size_t resp_length)
>  {
>  	int retry_cnt;
>  	int ret;
> @@ -1350,14 +1353,14 @@ static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
>  		return -ENODEV;
>  	}
>  
> -	ret = read_response(client, resp);
> +	ret = read_response(client, resp, resp_length);
>  	if (ret > 0) {
>  		/* Validate that the response is correct. */
>  		if (ret < 3 ||
>  		    (resp[0] != (msg[0] | (1 << 2))) ||
>  		    (resp[1] != msg[1]))
>  			ret = -EINVAL;
> -		else if (ret > IPMI_MAX_MSG_LENGTH) {
> +		else if (ret > resp_length) {
>  			ret = -E2BIG;
>  		} else {
>  			*resp_len = ret;
> @@ -1382,7 +1385,7 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	/* Do a Get Device ID command, since it is required. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_DEVICE_ID_CMD;
> -	rv = do_cmd(client, 2, msg, &len, resp);
> +	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv)
>  		rv = -ENODEV;
>  	else {
> @@ -1523,7 +1526,7 @@ static int start_multipart_test(struct i2c_client *client,
>  
>  static void test_multipart_messages(struct i2c_client *client,
>  				    struct ssif_info *ssif_info,
> -				    unsigned char *resp)
> +				    unsigned char *resp, size_t resp_length)
>  {
>  	unsigned char msg[65];
>  	int ret;
> @@ -1572,7 +1575,7 @@ static void test_multipart_messages(struct i2c_client *client,
>  					 1, msg + 64);
>  
>  	if (!ret)
> -		ret = read_response(client, resp);
> +		ret = read_response(client, resp, resp_length);
>  
>  	if (ret > 0) {
>  		/* End transactions work, we are good. */
> @@ -1590,7 +1593,7 @@ static void test_multipart_messages(struct i2c_client *client,
>  					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
>  					 0, msg + 64);
>  	if (!ret)
> -		ret = read_response(client, resp);
> +		ret = read_response(client, resp, resp_length);
>  	if (ret > 0)
>  		/* Zero-size end parts work, use those. */
>  		return;
> @@ -1748,7 +1751,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
>  	msg[2] = 0; /* SSIF */
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (!rv && (len >= 3) && (resp[2] == 0)) {
>  		if (len < 7) {
>  			if (ssif_dbg_probe)
> @@ -1800,13 +1803,13 @@ static int ssif_probe(struct i2c_client *client)
>  		ssif_info->supports_pec = 0;
>  	}
>  
> -	test_multipart_messages(client, ssif_info, resp);
> +	test_multipart_messages(client, ssif_info, resp, IPMI_MAX_MSG_LENGTH);
>  
>  	/* Make sure the NMI timeout is cleared. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
>  	msg[2] = WDT_PRE_TIMEOUT_INT;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 3) || (resp[2] != 0))
>  		dev_warn(&ssif_info->client->dev,
>  			 "Unable to clear message flags: %d %d %2.2x\n",
> @@ -1815,7 +1818,7 @@ static int ssif_probe(struct i2c_client *client)
>  	/* Attempt to enable the event buffer. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
> -	rv = do_cmd(client, 2, msg, &len, resp);
> +	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 4) || (resp[2] != 0)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error getting global enables: %d %d %2.2x\n",
> @@ -1835,7 +1838,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_EVT_MSG_BUFF;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> @@ -1857,7 +1860,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_RCV_MSG_INTR;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> 
> -- 
> 2.56.0.257.gf7497c7d27-goog
> 
