<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Response;

class CasinoController extends AbstractController
{
    #[Route(path: '/casino', name: 'app_casino_home')]
    public function index(): Response
    {
        return $this->render('casino/play.html.twig', [
            'gameDuration' => 3,
            'gameStarted' => false,
        ]);
    }
}
