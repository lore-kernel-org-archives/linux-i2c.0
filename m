From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: RE: [PATCH v9 1/1] Add support for IPMB driver
Date: Mon, 20 May 2019 14:50:41 +0000
Message-ID: <VI1PR05MB623971FF6F956A091840716DDA060@VI1PR05MB6239.eurprd05.prod.outlook.com>
References: <cover.1557322882.git.Asmaa@mellanox.com>
 <a4d9fe418013b604e7224bf3038c294da42d5534.1557322882.git.Asmaa@mellanox.com>
 <20190519140231.GA7291@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190519140231.GA7291@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "minyard@acm.org" <minyard@acm.org>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



-----Original Message-----
From: Wolfram Sang <wsa@the-dreams.de>=20
Sent: Sunday, May 19, 2019 10:03 AM
To: Asmaa Mnebhi <Asmaa@mellanox.com>
Cc: minyard@acm.org; Vadim Pasternak <vadimp@mellanox.com>; Michael Shych <=
michaelsh@mellanox.com>; rdunlap@infradead.org; linux-kernel@vger.kernel.or=
g; linux-i2c@vger.kernel.org
Subject: Re: [PATCH v9 1/1] Add support for IPMB driver


> +static int receive_ipmb_request(struct ipmb_dev *ipmb_dev,
> +				bool non_blocking,
> +				struct ipmb_msg *ipmb_request)
> +{
> +	struct ipmb_request_elem *queue_elem;
> +	unsigned long flags;
> +	int res;
> +
> +	spin_lock_irqsave(&ipmb_dev->lock, flags);
> +
> +	while (!atomic_read(&ipmb_dev->request_queue_len)) {

>> Am I overlooking something? Why are you protecting an atomic_read with a=
 spinlock?

A thread would lock the ipmb_dev->lock spinlock (above) for all the code be=
low ONLY IF the atomic_read for the request_queue_len reports a value diffe=
rent from 0:

if (list_empty(&ipmb_dev->request_queue)) {
260 +               dev_err(&ipmb_dev->client->dev, "request_queue is empty=
\n");
261 +               spin_unlock_irqrestore(&ipmb_dev->lock, flags);
262 +               return -EIO;
263 +       }
264 +
265 +       queue_elem =3D list_first_entry(&ipmb_dev->request_queue,
266 +                                       struct ipmb_request_elem, list)=
;
267 +       memcpy(ipmb_request, &queue_elem->request, sizeof(*ipmb_request=
));
268 +       list_del(&queue_elem->list);
269 +       kfree(queue_elem);
270 +       atomic_dec(&ipmb_dev->request_queue_len);
271 +
272 +       spin_unlock_irqrestore(&ipmb_dev->lock, flags);

 This is important because we do not want another thread to change/use the =
wrong value of request_queue_len, which is decremented eventually.

If the atomic read for the request_queue_len is 0, then we release the cloc=
k and call wait_event_interruptible until we receive something in the queue=
 (i.e. request_queue_len has a value different from 0).
The function ipmb_handle_request takes care of incrementing the value of re=
quest_queue_len and waking up the wait_queue.

> +		spin_unlock_irqrestore(&ipmb_dev->lock, flags);
> +
> +		if (non_blocking)
> +			return -EAGAIN;
> +
> +		res =3D wait_event_interruptible(ipmb_dev->wait_queue,
> +				atomic_read(&ipmb_dev->request_queue_len));
> +		if (res)
> +			return res;
> +
> +		spin_lock_irqsave(&ipmb_dev->lock, flags);
> +	}

...

> +	rq_sa =3D msg[RQ_SA_8BIT_IDX] >> 1;
> +	netf_rq_lun =3D msg[NETFN_LUN_IDX];
> +	/*
> +	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
> +	 * i2c_smbus_write_block_data_local
> +	 */
> +	msg_len =3D msg[IPMB_MSG_LEN_IDX] - SMBUS_MSG_HEADER_LENGTH;
> +
> +	strcpy(rq_client.name, "ipmb_requester");
> +	rq_client.adapter =3D ipmb_dev->client->adapter;
> +	rq_client.flags =3D ipmb_dev->client->flags;
> +	rq_client.addr =3D rq_sa;

>> Is it possible to determine in a race-free way if rq_sa (which came from=
 userspace AFAIU) is really the address from which the request came in (aga=
in if I understood all this correctly)?
Yes there is. I see 2 options:

1) This is less explicit than option 2 but uses existing code and is simple=
r. we can use the ipmb_verify_checksum1 function since the IPMB response fo=
rmat is as follows:
Byte 1: rq_sa
Byte 2: netfunction/rqLUN
Byte 3: checksum1

So if checksum1 is verified, it means rq_sa is correct.

2) I am not sure we want this but have a global variable which stores the a=
ddress of the requester once the first request is received. We would compar=
e that address with the one received from userspace in the code above.
