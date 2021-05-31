<?php

namespace App\Mail;

use App\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class OrderPlaced extends Mailable
{
    use Queueable, SerializesModels;

    public $order;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $headers  = "From: hungerrasoicare@gmail.com\r\n";
        $headers .= "Reply-To: hungerrasoicare@gmail.com\r\n";
        $headers .= "Return-Path: hungerrasoicare@gmail.com\r\n";
        $headers .= "BCC: hungerrasoicare@gmail.com\r\n";
        return $this->to($this->order->billing_email, $this->order->billing_name)
                    ->bcc('hungerrasoicare@gmail.com')
                    ->from("hungerrasoicare@gmail.com", "HungerRasoi")
                    ->subject('Order From HungerRasoi.')
                    ->markdown('emails.orders.placed');
    }
}
